-- Motor de examen. Ejecutar después de schema.sql.
-- Este script migra la tabla antigua creada por versiones previas.

create table if not exists public.exam_questions (
    id uuid primary key default gen_random_uuid(),
    question_type text not null check (question_type in ('attitude', 'knowledge')),
    module text not null check (module in ('vehicle', 'signage_infrastructure', 'traffic_rules', 'safe_mobility', 'attitudes')),
    category text[] not null check (cardinality(category) > 0 and category <@ array['A2', 'B1', 'C1']::text[]),
    difficulty text not null default 'medium' check (difficulty in ('easy', 'medium', 'hard')),
    question_text text not null,
    option_a text not null, option_b text not null, option_c text not null, option_d text not null,
    correct_option text not null check (correct_option in ('A', 'B', 'C', 'D')),
    explanation text, legal_source text, legal_article text, legal_reference text,
    image_url text, active boolean not null default true,
    created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
    constraint exam_questions_type_module_check check (
        (question_type = 'attitude' and module = 'attitudes') or
        (question_type = 'knowledge' and module <> 'attitudes')
    )
);

create table if not exists public.exam_attempts (id uuid primary key default gen_random_uuid());
alter table public.exam_attempts add column if not exists user_id uuid references auth.users(id) on delete cascade;
alter table public.exam_attempts add column if not exists category text;
alter table public.exam_attempts add column if not exists started_at timestamptz not null default now();
alter table public.exam_attempts add column if not exists finished_at timestamptz;
alter table public.exam_attempts add column if not exists duration_seconds integer;
alter table public.exam_attempts add column if not exists total_questions integer not null default 40;
alter table public.exam_attempts add column if not exists total_correct integer not null default 0;
alter table public.exam_attempts add column if not exists total_score numeric(5,2) not null default 0;
alter table public.exam_attempts add column if not exists passed boolean not null default false;
alter table public.exam_attempts add column if not exists status text not null default 'in_progress';
alter table public.exam_attempts add column if not exists created_at timestamptz not null default now();
do $$ begin
    if exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'exam_attempts' and column_name = 'categoria') then
        execute 'update public.exam_attempts set category = categoria where category is null';
    end if;
    if exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'exam_attempts' and column_name = 'score') then
        execute 'update public.exam_attempts set total_score = coalesce(total_score, score)';
    end if;
end $$;
alter table public.exam_attempts drop column if exists categoria;
alter table public.exam_attempts drop column if exists score;
alter table public.exam_attempts drop column if exists correct_answers;
alter table public.exam_attempts drop column if exists incorrect_answers;
alter table public.exam_attempts drop column if exists completed_at;
alter table public.exam_attempts drop column if exists attitude_correct;
alter table public.exam_attempts drop column if exists knowledge_correct;
alter table public.exam_attempts drop column if exists attitude_score;
alter table public.exam_attempts drop column if exists knowledge_score;
alter table public.exam_attempts drop column if exists attitude_passed;
alter table public.exam_attempts drop column if exists knowledge_passed;
alter table public.exam_attempts drop constraint if exists exam_attempts_category_check;
alter table public.exam_attempts add constraint exam_attempts_category_check check (category in ('A2', 'B1', 'C1'));
alter table public.exam_attempts drop constraint if exists exam_attempts_status_check;
alter table public.exam_attempts add constraint exam_attempts_status_check check (status in ('in_progress', 'completed', 'expired', 'cancelled'));

create table if not exists public.exam_attempt_questions (
    id uuid primary key default gen_random_uuid(),
    attempt_id uuid not null references public.exam_attempts(id) on delete cascade,
    question_id uuid not null references public.exam_questions(id),
    question_order integer not null check (question_order between 1 and 40),
    selected_option text check (selected_option is null or selected_option in ('A', 'B', 'C', 'D')),
    is_correct boolean, answered_at timestamptz, created_at timestamptz not null default now(),
    unique (attempt_id, question_order), unique (attempt_id, question_id)
);

create index if not exists exam_questions_category_active_idx on public.exam_questions using gin(category);
create index if not exists exam_attempts_user_created_idx on public.exam_attempts(user_id, created_at desc);
create index if not exists exam_attempt_questions_attempt_idx on public.exam_attempt_questions(attempt_id);

-- Vista pública: nunca entrega correct_option ni explicación antes del cierre.
create or replace view public.exam_questions_for_students
with (security_invoker = true) as
select id, question_type, module, category, difficulty, question_text, option_a, option_b, option_c, option_d, image_url
from public.exam_questions where active = true;

alter table public.exam_questions enable row level security;
alter table public.exam_attempts enable row level security;
alter table public.exam_attempt_questions enable row level security;

drop policy if exists "students read active questions" on public.exam_questions;
create policy "students read active questions" on public.exam_questions for select to authenticated using (active);
drop policy if exists "students read own attempts" on public.exam_attempts;
create policy "students read own attempts" on public.exam_attempts for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "students read own assigned questions" on public.exam_attempt_questions;
create policy "students read own assigned questions" on public.exam_attempt_questions for select to authenticated using (exists (select 1 from public.exam_attempts a where a.id = attempt_id and a.user_id = (select auth.uid())));

revoke all on public.exam_questions, public.exam_attempts, public.exam_attempt_questions from authenticated;
grant select (id, question_type, module, category, difficulty, question_text, option_a, option_b, option_c, option_d, image_url, active) on public.exam_questions to authenticated;
grant select on public.exam_questions_for_students, public.exam_attempts, public.exam_attempt_questions to authenticated;

create or replace function public.start_exam_attempt()
returns uuid language plpgsql security definer set search_path = public as $$
declare v_user uuid := auth.uid(); v_category text; v_attempt uuid;
begin
    if v_user is null then raise exception 'Sesión no válida'; end if;
    select categoria into v_category from profiles where id = v_user;
    if v_category not in ('A2', 'B1', 'C1') then raise exception 'Categoría de perfil no válida'; end if;
    if exists (select 1 from exam_attempts where user_id = v_user and status = 'in_progress') then raise exception 'Ya existe un intento en curso'; end if;
    if (select count(*) from exam_attempts where user_id = v_user and status in ('completed', 'expired')) >= 3 then raise exception 'Se agotaron los intentos disponibles'; end if;
    if (select count(*) from exam_questions where active and category @> array[v_category]) < 40 then raise exception 'No hay 40 preguntas disponibles para la categoría %', v_category; end if;
    insert into exam_attempts (user_id, category, total_questions) values (v_user, v_category, 40) returning id into v_attempt;
    with ranked as (
        select q.id, row_number() over (partition by q.module order by random()) as rn
        from exam_questions q where q.active and q.category @> array[v_category]
    ), chosen as (
        select id from ranked where (module = 'attitudes' and rn <= 12) or (module <> 'attitudes' and rn <= 7)
    )
    insert into exam_attempt_questions (attempt_id, question_id, question_order)
    select v_attempt, id, row_number() over (order by random()) from chosen;
    if (select count(*) from exam_attempt_questions where attempt_id = v_attempt) <> 40 then
        delete from exam_attempts where id = v_attempt;
        raise exception 'El banco no tiene la distribución temática requerida';
    end if;
    return v_attempt;
end $$;

create or replace function public.save_exam_answer(p_attempt uuid, p_order integer, p_option text)
returns void language plpgsql security definer set search_path = public as $$
begin
    if p_option not in ('A','B','C','D') then raise exception 'Respuesta inválida'; end if;
    update exam_attempt_questions aq set selected_option = p_option, answered_at = now()
    from exam_attempts a where aq.attempt_id = a.id and aq.attempt_id = p_attempt and aq.question_order = p_order
      and a.user_id = auth.uid() and a.status = 'in_progress' and a.started_at > now() - interval '70 minutes';
    if not found then raise exception 'No se puede actualizar esta respuesta'; end if;
end $$;

create or replace function public.finish_exam_attempt(p_attempt uuid, p_expired boolean default false)
returns void language plpgsql security definer set search_path = public as $$
begin
    update exam_attempt_questions aq set is_correct = (aq.selected_option = q.correct_option)
    from exam_questions q, exam_attempts a where aq.question_id = q.id and a.id = aq.attempt_id
      and aq.attempt_id = p_attempt and a.user_id = auth.uid() and a.status = 'in_progress';
    update exam_attempts a set finished_at = now(), duration_seconds = greatest(0, extract(epoch from now() - a.started_at)::integer),
        total_correct = (select count(*) from exam_attempt_questions where attempt_id = a.id and is_correct),
        total_score = round(100.0 * (select count(*) from exam_attempt_questions where attempt_id = a.id and is_correct) / a.total_questions, 2),
        passed = (select count(*) from exam_attempt_questions where attempt_id = a.id and is_correct) * 100 >= a.total_questions * 80,
        status = case when p_expired or now() >= a.started_at + interval '70 minutes' then 'expired' else 'completed' end
    where a.id = p_attempt and a.user_id = auth.uid() and a.status = 'in_progress';
    if not found then raise exception 'No se puede finalizar este intento'; end if;
end $$;

grant execute on function public.start_exam_attempt(), public.save_exam_answer(uuid, integer, text), public.finish_exam_attempt(uuid, boolean) to authenticated;
