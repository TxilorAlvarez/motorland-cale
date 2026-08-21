-- =========================================================
-- MOTORLAND CALE — MOTOR DEFINITIVO DE EXAMEN
-- =========================================================
-- Ejecutar en Supabase SQL Editor.
-- Este archivo es una MIGRACIÓN NO DESTRUCTIVA:
-- NO borra respuestas, intentos ni preguntas existentes.
--
-- ORDEN:
--   1) Ejecutar este archivo completo en Supabase.
--   2) NO ejecutar hotfix_save_exam_answer.sql después.
--   3) NO es necesario volver a ejecutar examen.sql antiguo.
--   4) Recargar la página del simulador.
--
-- Estructura CALE:
--   40 preguntas
--   12 actitudinales
--   28 conocimientos:
--      10 movilidad segura y sostenible
--       6 normas de tránsito
--       6 señalización e infraestructura
--       6 vehículo
--   Tiempo máximo: 40 minutos
--   Aprobación: >=80% conocimientos Y >=80% actitudes
-- =========================================================


-- =========================================================
-- 1. TABLA DE PREGUNTAS
-- =========================================================

create table if not exists public.exam_questions (
    id uuid primary key default gen_random_uuid(),

    question_type text not null
        check (question_type in ('attitude', 'knowledge')),

    module text not null
        check (
            module in (
                'vehicle',
                'signage_infrastructure',
                'traffic_rules',
                'safe_mobility',
                'attitudes'
            )
        ),

    category text[] not null
        check (
            cardinality(category) > 0
            and category <@ array['A2','B1','C1','GENERAL']::text[]
        ),

    difficulty text not null default 'medium'
        check (difficulty in ('easy','medium','hard')),

    question_text text not null,

    option_a text not null,
    option_b text not null,
    option_c text not null,
    option_d text not null,

    correct_option text not null
        check (correct_option in ('A','B','C','D')),

    explanation text,
    legal_source text,
    legal_article text,
    legal_reference text,
    fundament_type text,
    technical_source text,
    source_note text,
    image_url text,

    active boolean not null default true,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),

    constraint exam_questions_type_module_check check (
        (question_type = 'attitude' and module = 'attitudes')
        or
        (question_type = 'knowledge' and module <> 'attitudes')
    )
);

-- La columna category es text[] para poder incluir preguntas aplicables a más
-- de una categoría. Este índice se crea aquí (la tabla aún no existe al correr
-- schema.sql en una instalación nueva).
create index if not exists idx_exam_questions_category
    on public.exam_questions using gin (category);

-- El banco clasifica las preguntas por módulo. Este trigger mantiene el tipo
-- coherente con esa clasificación al importar o actualizar contenido.
create or replace function public.set_exam_question_type()
returns trigger
language plpgsql
set search_path = public
as $$
begin
    new.question_type := case
        when new.module = 'attitudes' then 'attitude'
        else 'knowledge'
    end;
    return new;
end;
$$;

drop trigger if exists set_exam_question_type on public.exam_questions;
create trigger set_exam_question_type
before insert or update of module on public.exam_questions
for each row execute function public.set_exam_question_type();


-- =========================================================
-- 2. TABLA DE INTENTOS
-- =========================================================

create table if not exists public.exam_attempts (
    id uuid primary key default gen_random_uuid()
);

alter table public.exam_attempts
    add column if not exists user_id uuid
        references auth.users(id) on delete cascade;

alter table public.exam_attempts
    add column if not exists category text;

alter table public.exam_attempts
    add column if not exists started_at timestamptz
        not null default now();

alter table public.exam_attempts
    add column if not exists finished_at timestamptz;

alter table public.exam_attempts
    add column if not exists duration_seconds integer;

alter table public.exam_attempts
    add column if not exists total_questions integer
        not null default 40;

alter table public.exam_attempts
    add column if not exists attitude_correct integer
        not null default 0;

alter table public.exam_attempts
    add column if not exists knowledge_correct integer
        not null default 0;

alter table public.exam_attempts
    add column if not exists total_correct integer
        not null default 0;

alter table public.exam_attempts
    add column if not exists attitude_score numeric(5,2)
        not null default 0;

alter table public.exam_attempts
    add column if not exists knowledge_score numeric(5,2)
        not null default 0;

alter table public.exam_attempts
    add column if not exists total_score numeric(5,2)
        not null default 0;

alter table public.exam_attempts
    add column if not exists attitude_passed boolean
        not null default false;

alter table public.exam_attempts
    add column if not exists knowledge_passed boolean
        not null default false;

alter table public.exam_attempts
    add column if not exists passed boolean
        not null default false;

alter table public.exam_attempts
    add column if not exists status text
        not null default 'in_progress';

alter table public.exam_attempts
    add column if not exists created_at timestamptz
        not null default now();


-- =========================================================
-- 3. NORMALIZACIÓN DE DATOS ANTIGUOS
-- =========================================================

do $$
begin
    if exists (
        select 1
        from information_schema.columns
        where table_schema = 'public'
          and table_name = 'exam_attempts'
          and column_name = 'categoria'
    ) then
        execute '
            update public.exam_attempts
               set category = categoria
             where category is null
        ';
    end if;

    if exists (
        select 1
        from information_schema.columns
        where table_schema = 'public'
          and table_name = 'exam_attempts'
          and column_name = 'score'
    ) then
        execute '
            update public.exam_attempts
               set total_score = coalesce(total_score, score)
             where total_score = 0
        ';
    end if;
end
$$;


-- =========================================================
-- 4. CONSTRAINTS DE INTENTOS
-- =========================================================

alter table public.exam_attempts
    drop constraint if exists exam_attempts_category_check;

alter table public.exam_attempts
    add constraint exam_attempts_category_check
    check (category in ('A2','B1','C1'));

alter table public.exam_attempts
    drop constraint if exists exam_attempts_status_check;

alter table public.exam_attempts
    add constraint exam_attempts_status_check
    check (
        status in (
            'in_progress',
            'completed',
            'expired',
            'cancelled'
        )
    );


-- =========================================================
-- 5. PREGUNTAS ASIGNADAS A CADA INTENTO
-- =========================================================

create table if not exists public.exam_attempt_questions (
    id uuid primary key default gen_random_uuid(),

    attempt_id uuid not null
        references public.exam_attempts(id)
        on delete cascade,

    question_id uuid not null
        references public.exam_questions(id),

    question_order integer not null
        check (question_order between 1 and 40),

    selected_option text
        check (
            selected_option is null
            or selected_option in ('A','B','C','D')
        ),

    is_correct boolean,

    answered_at timestamptz,

    created_at timestamptz not null default now(),

    unique (attempt_id, question_order),
    unique (attempt_id, question_id)
);


-- =========================================================
-- 6. ÍNDICES
-- =========================================================

create index if not exists exam_questions_category_active_idx
    on public.exam_questions using gin(category);

create index if not exists exam_attempts_user_created_idx
    on public.exam_attempts(user_id, created_at desc);

create index if not exists exam_attempt_questions_attempt_idx
    on public.exam_attempt_questions(attempt_id);


-- =========================================================
-- 7. VISTA SEGURA PARA ESTUDIANTES
--    Nunca entrega correct_option mientras se presenta.
-- =========================================================

drop view if exists public.exam_questions_for_students;

create view public.exam_questions_for_students
with (security_invoker = true) as
select
    id,
    question_type,
    module,
    category,
    difficulty,
    question_text,
    option_a,
    option_b,
    option_c,
    option_d,
    image_url
from public.exam_questions
where active = true;


-- =========================================================
-- 8. RLS
-- =========================================================

alter table public.exam_questions enable row level security;
alter table public.exam_attempts enable row level security;
alter table public.exam_attempt_questions enable row level security;


drop policy if exists "students read active questions"
    on public.exam_questions;

    create policy "students read active questions"
    on public.exam_questions
    for select
    to authenticated
    using (active);


drop policy if exists "students read own attempts"
    on public.exam_attempts;

create policy "students read own attempts"
on public.exam_attempts
for select
to authenticated
using (
    (select auth.uid()) = user_id
    or public.is_admin()
);


drop policy if exists "students read own assigned questions"
    on public.exam_attempt_questions;

create policy "students read own assigned questions"
on public.exam_attempt_questions
for select
to authenticated
using (
    exists (
        select 1
        from public.exam_attempts a
        where a.id = attempt_id
          and a.user_id = (select auth.uid())
    )
    or public.is_admin()
);


-- =========================================================
-- 9. PERMISOS
-- =========================================================

revoke all
on public.exam_questions,
   public.exam_attempts,
   public.exam_attempt_questions
from authenticated;

grant select (
    id,
    question_type,
    module,
    category,
    difficulty,
    question_text,
    option_a,
    option_b,
    option_c,
    option_d,
    image_url,
    active
)
on public.exam_questions
to authenticated;

grant select
on public.exam_questions_for_students,
   public.exam_attempts,
   public.exam_attempt_questions
to authenticated;


-- =========================================================
-- 10. INICIAR / RETOMAR INTENTO
-- =========================================================

create or replace function public.start_exam_attempt()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
    v_user uuid := auth.uid();
    v_category text;
    v_attempt uuid;
begin

    if v_user is null then
        raise exception 'Sesión no válida';
    end if;


    select categoria
      into v_category
      from public.profiles
     where id = v_user;


    if v_category not in ('A2','B1','C1') then
        raise exception 'Categoría de perfil no válida';
    end if;


    -- Cerrar intentos vencidos. Un intento que nunca recibió una respuesta es
    -- abandonado/cancelado y no consume uno de los tres cupos; uno que sí tuvo
    -- actividad queda como expirado y conserva su trazabilidad.
    update public.exam_attempts a
       set status = case
               when exists (
                   select 1
                   from public.exam_attempt_questions aq
                   where aq.attempt_id = a.id
                     and aq.selected_option is not null
               ) then 'expired'
               else 'cancelled'
           end,
           finished_at = now(),
           duration_seconds = greatest(
               0,
               extract(epoch from now() - a.started_at)::integer
           )
     where a.user_id = v_user
       and a.status = 'in_progress'
       and a.started_at <= now() - interval '40 minutes';


    -- Si existe un intento vigente, se retoma.
    select id
      into v_attempt
      from public.exam_attempts
     where user_id = v_user
       and status = 'in_progress'
     order by started_at desc
     limit 1;


    if v_attempt is not null then
        return v_attempt;
    end if;


    -- Máximo 3 intentos finalizados.
    if (
        select count(*)
        from public.exam_attempts
        where user_id = v_user
          and status in ('completed','expired')
    ) >= 3 then

        raise exception 'Se agotaron los intentos disponibles';

    end if;


    -- Deben existir al menos 40 preguntas.
    if (
        select count(*)
        from public.exam_questions
        where active
          and category @> array[v_category]
    ) < 40 then

        raise exception
            'No hay 40 preguntas disponibles para la categoría %',
            v_category;

    end if;


    -- Crear intento.
    insert into public.exam_attempts (
        user_id,
        category,
        total_questions,
        started_at,
        status
    )
    values (
        v_user,
        v_category,
        40,
        now(),
        'in_progress'
    )
    returning id into v_attempt;


    -- Selección CALE:
    -- 12 actitudes
    -- 10 movilidad
    --  6 normas
    --  6 señalización
    --  6 vehículo
    --
    -- IMPORTANTE:
    -- Se incluye module en ranked.
    with ranked as (
        select
            q.id,
            q.module,
            row_number() over (
                partition by q.module
                order by random()
            ) as rn
        from public.exam_questions q
        where q.active
          and q.category @> array[v_category]
    ),
    chosen as (
        select id
        from ranked
        where
            (module = 'attitudes' and rn <= 12)
            or
            (module = 'safe_mobility' and rn <= 10)
            or
            (module = 'traffic_rules' and rn <= 6)
            or
            (module = 'signage_infrastructure' and rn <= 6)
            or
            (module = 'vehicle' and rn <= 6)
    )
    insert into public.exam_attempt_questions (
        attempt_id,
        question_id,
        question_order
    )
    select
        v_attempt,
        id,
        row_number() over (order by random())
    from chosen;


    -- Protección de integridad:
    -- exactamente 40 preguntas.
    if (
        select count(*)
        from public.exam_attempt_questions
        where attempt_id = v_attempt
    ) <> 40 then

        delete
        from public.exam_attempts
        where id = v_attempt;

        raise exception
            'El banco no tiene la distribución temática requerida';

    end if;


    return v_attempt;

end;
$$;


-- =========================================================
-- 11. GUARDAR RESPUESTA
-- =========================================================

create or replace function public.save_exam_answer(
    p_attempt uuid,
    p_order integer,
    p_option text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin

    if auth.uid() is null then
        raise exception 'Sesión no válida';
    end if;


    if p_option not in ('A','B','C','D') then
        raise exception 'Respuesta inválida';
    end if;


    if p_order < 1 or p_order > 40 then
        raise exception 'Número de pregunta inválido';
    end if;


    update public.exam_attempt_questions aq
       set selected_option = p_option,
           answered_at = now()
      from public.exam_attempts a
     where aq.attempt_id = a.id
       and aq.attempt_id = p_attempt
       and aq.question_order = p_order
       and a.user_id = auth.uid()
       and a.status = 'in_progress'
       and a.started_at > now() - interval '40 minutes';


    if not found then
        raise exception 'No se puede actualizar esta respuesta';
    end if;

end;
$$;


-- =========================================================
-- 12. FINALIZAR Y CALIFICAR
-- =========================================================

create or replace function public.finish_exam_attempt(
    p_attempt uuid,
    p_expired boolean default false
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
    v_user uuid := auth.uid();

    v_attitude_correct integer := 0;
    v_knowledge_correct integer := 0;
    v_total_correct integer := 0;

    v_attitude_score numeric(5,2) := 0;
    v_knowledge_score numeric(5,2) := 0;
    v_total_score numeric(5,2) := 0;

    v_attitude_passed boolean := false;
    v_knowledge_passed boolean := false;
    v_passed boolean := false;

    v_total_questions integer := 40;
begin

    if v_user is null then
        raise exception 'Sesión no válida';
    end if;


    -- Marcar cada respuesta.
    update public.exam_attempt_questions aq
       set is_correct =
           (
               aq.selected_option is not null
               and aq.selected_option = q.correct_option
           )
      from public.exam_questions q,
           public.exam_attempts a
     where aq.question_id = q.id
       and a.id = aq.attempt_id
       and aq.attempt_id = p_attempt
       and a.user_id = v_user
       and a.status = 'in_progress';


    -- Contar ACTITUDES.
    select count(*)
      into v_attitude_correct
      from public.exam_attempt_questions aq
      join public.exam_questions q
        on q.id = aq.question_id
     where aq.attempt_id = p_attempt
       and q.question_type = 'attitude'
       and aq.is_correct = true;


    -- Contar CONOCIMIENTOS.
    select count(*)
      into v_knowledge_correct
      from public.exam_attempt_questions aq
      join public.exam_questions q
        on q.id = aq.question_id
     where aq.attempt_id = p_attempt
       and q.question_type = 'knowledge'
       and aq.is_correct = true;


    v_total_correct :=
        v_attitude_correct +
        v_knowledge_correct;


    -- 12 actitudinales.
    v_attitude_score :=
        round(
            100.0 * v_attitude_correct / 12.0,
            2
        );


    -- 28 conocimientos.
    v_knowledge_score :=
        round(
            100.0 * v_knowledge_correct / 28.0,
            2
        );


    -- 40 total.
    v_total_score :=
        round(
            100.0 * v_total_correct / 40.0,
            2
        );


    -- REGLA DE APROBACIÓN:
    -- conocimientos >= 80%
    -- Y actitudes >= 80%
    v_attitude_passed :=
        v_attitude_score >= 80;

    v_knowledge_passed :=
        v_knowledge_score >= 80;

    v_passed :=
        v_attitude_passed
        and v_knowledge_passed;


    -- Guardar resultado completo.
    update public.exam_attempts a
       set finished_at = now(),

           duration_seconds =
               greatest(
                   0,
                   extract(
                       epoch from now() - a.started_at
                   )::integer
               ),

           total_questions = v_total_questions,

           attitude_correct = v_attitude_correct,
           knowledge_correct = v_knowledge_correct,
           total_correct = v_total_correct,

           attitude_score = v_attitude_score,
           knowledge_score = v_knowledge_score,
           total_score = v_total_score,

           attitude_passed = v_attitude_passed,
           knowledge_passed = v_knowledge_passed,
           passed = v_passed,

           status =
               case
                   when p_expired
                        or now() >= a.started_at + interval '40 minutes'
                   then 'expired'
                   else 'completed'
               end

     where a.id = p_attempt
       and a.user_id = v_user
       and a.status = 'in_progress';


    if not found then
        raise exception 'No se puede finalizar este intento';
    end if;

end;
$$;


-- =========================================================
-- 13. VISTA DE RESULTADO DEL INTENTO
-- =========================================================
-- Esta vista permite al estudiante consultar su propio
-- resultado después de finalizar.
-- =========================================================

drop view if exists public.exam_attempt_results;

create view public.exam_attempt_results
with (security_invoker = true) as
select
    a.id as attempt_id,
    a.user_id,
    a.category,
    a.started_at,
    a.finished_at,
    a.duration_seconds,
    a.total_questions,

    a.attitude_correct,
    12 as attitude_total,
    a.attitude_score,
    a.attitude_passed,

    a.knowledge_correct,
    28 as knowledge_total,
    a.knowledge_score,
    a.knowledge_passed,

    a.total_correct,
    40 as total_question_count,
    a.total_score,
    a.passed,
    a.status,
    a.created_at

from public.exam_attempts a;


grant select
on public.exam_attempt_results
to authenticated;


-- =========================================================
-- 14. VISTA DE RESULTADOS POR NÚCLEO TEMÁTICO
-- =========================================================
-- Esto NO cambia la regla legal de aprobación.
-- Sirve para detectar áreas que el estudiante debe reforzar.
-- =========================================================

drop view if exists public.exam_attempt_module_results;

create view public.exam_attempt_module_results
with (security_invoker = true) as
select
    a.id as attempt_id,
    a.user_id,
    a.category,
    a.status,

    q.module,

    count(*)::integer as total_questions,

    count(*) filter (
        where aq.is_correct = true
    )::integer as correct_answers,

    count(*) filter (
        where aq.is_correct is false
    )::integer as incorrect_answers,

    round(
        100.0 *
        count(*) filter (
            where aq.is_correct = true
        )
        / nullif(count(*),0),
        2
    ) as score,

    (
        round(
            100.0 *
            count(*) filter (
                where aq.is_correct = true
            )
            / nullif(count(*),0),
            2
        ) >= 80
    ) as passed

from public.exam_attempts a

join public.exam_attempt_questions aq
  on aq.attempt_id = a.id

join public.exam_questions q
  on q.id = aq.question_id

group by
    a.id,
    a.user_id,
    a.category,
    a.status,
    q.module;


grant select
on public.exam_attempt_module_results
to authenticated;


-- =========================================================
-- 15. VISTA DE PREGUNTAS FALLADAS
-- =========================================================
-- IMPORTANTE:
-- correct_option y explicación solamente aparecen después
-- de que el intento haya terminado.
-- =========================================================

drop view if exists public.exam_attempt_review;

create view public.exam_attempt_review
with (security_invoker = true) as
select
    a.id as attempt_id,
    a.user_id,
    a.category,
    a.status,

    aq.question_order,
    aq.question_id,

    q.question_type,
    q.module,
    q.question_text,

    q.option_a,
    q.option_b,
    q.option_c,
    q.option_d,

    aq.selected_option,
    q.correct_option,

    aq.is_correct,
    aq.answered_at,

    q.explanation,
    q.legal_source,
    q.legal_article,
    q.legal_reference,
    q.fundament_type,
    q.technical_source,
    q.source_note,
    q.image_url

from public.exam_attempts a

join public.exam_attempt_questions aq
  on aq.attempt_id = a.id

join public.exam_questions q
  on q.id = aq.question_id

where a.status in ('completed','expired');


grant select
on public.exam_attempt_review
to authenticated;


-- =========================================================
-- 16. PERMISOS DE FUNCIONES
-- =========================================================

revoke all
on function public.start_exam_attempt()
from public;

revoke all
on function public.save_exam_answer(uuid, integer, text)
from public;

revoke all
on function public.finish_exam_attempt(uuid, boolean)
from public;


grant execute
on function public.start_exam_attempt()
to authenticated;

grant execute
on function public.save_exam_answer(uuid, integer, text)
to authenticated;

grant execute
on function public.finish_exam_attempt(uuid, boolean)
to authenticated;

-- Consultas exclusivas del panel administrativo. SECURITY DEFINER no basta:
-- cada función valida el rol almacenado en profiles antes de devolver datos.
create or replace function public.admin_dashboard_data(p_category text default null)
returns jsonb language plpgsql security definer set search_path = public as $$
declare v_category text := nullif(upper(trim(p_category)), '');
begin
    if not public.is_admin() then raise exception 'No autorizado' using errcode = '42501'; end if;
    return jsonb_build_object(
        'summary', (select jsonb_build_object(
            'students', (select count(*) from public.profiles where role = 'student'),
            'attempts', count(*) filter (where status = 'completed'),
            'approved', count(*) filter (where status = 'completed' and passed),
            'failed', count(*) filter (where status = 'completed' and not passed),
            'pending', count(*) filter (where status = 'in_progress'),
            'average_score', coalesce(round(avg(total_score) filter (where status = 'completed'), 1), 0),
            'average_duration_seconds', coalesce(round(avg(duration_seconds) filter (where status = 'completed'), 0), 0)
        ) from public.exam_attempts where v_category is null or category = v_category),
        'modules', (select coalesce(jsonb_agg(row_to_json(x)), '[]'::jsonb) from (
            select q.module, round(100.0 * count(*) filter (where aq.is_correct) / nullif(count(*), 0), 1) as score
            from public.exam_attempt_questions aq join public.exam_attempts a on a.id = aq.attempt_id join public.exam_questions q on q.id = aq.question_id
            where a.status = 'completed' and (v_category is null or a.category = v_category) group by q.module order by q.module
        ) x),
        'recent', (select coalesce(jsonb_agg(row_to_json(x)), '[]'::jsonb) from (
            select a.id, a.category, a.total_score, a.total_correct, a.total_questions, a.duration_seconds, a.finished_at, a.passed,
                trim(concat(p.nombres, ' ', p.apellidos)) as student_name
            from public.exam_attempts a join public.profiles p on p.id = a.user_id
            where a.status = 'completed' and (v_category is null or a.category = v_category) order by a.finished_at desc limit 8
        ) x)
    );
end; $$;

create or replace function public.admin_results_page(p_page integer default 1, p_page_size integer default 25, p_category text default null, p_status text default null, p_search text default null)
returns jsonb language plpgsql security definer set search_path = public as $$
declare v_page integer := greatest(coalesce(p_page, 1), 1); v_size integer := least(greatest(coalesce(p_page_size, 25), 1), 50); v_category text := nullif(upper(trim(p_category)), ''); v_status text := nullif(lower(trim(p_status)), ''); v_search text := nullif(trim(p_search), '');
begin
    if not public.is_admin() then raise exception 'No autorizado' using errcode = '42501'; end if;
    return (with filtered as (
        select a.id, a.user_id, a.category, a.total_score, a.total_correct, a.total_questions, a.duration_seconds, a.finished_at, a.created_at, a.passed, a.status,
            p.nombres, p.apellidos, p.documento, p.matricula, p.correo
        from public.exam_attempts a join public.profiles p on p.id = a.user_id
        where a.status = 'completed' and (v_category is null or a.category = v_category)
          and (v_status is null or (v_status = 'approved' and a.passed) or (v_status = 'failed' and not a.passed))
          and (v_search is null or concat_ws(' ', p.nombres, p.apellidos, p.documento, p.matricula, p.correo) ilike '%' || v_search || '%')
    ) select jsonb_build_object('total', count(*), 'approved', count(*) filter (where passed), 'failed', count(*) filter (where not passed), 'average_score', coalesce(round(avg(total_score), 1), 0),
        'items', coalesce((select jsonb_agg(row_to_json(page_data)) from (select * from filtered order by finished_at desc offset (v_page - 1) * v_size limit v_size) page_data), '[]'::jsonb)) from filtered);
end; $$;

create or replace function public.admin_attempt_detail(p_attempt uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
begin
    if not public.is_admin() then raise exception 'No autorizado' using errcode = '42501'; end if;
    return (with target as (
        select a.*, p.nombres, p.apellidos, p.documento, p.matricula, p.correo, p.telefono 
        from public.exam_attempts a 
        join public.profiles p on p.id = a.user_id 
        where a.id = p_attempt
          and a.status = 'completed'
    ) select jsonb_build_object(
        'attempt', (select row_to_json(target) from target),
        'modules', coalesce((
            select jsonb_agg(row_to_json(x)) 
            from (
                select q.module, 
                       count(*) as total_questions, 
                       count(*) filter (where aq.is_correct) as correct_answers, 
                       round(100.0 * count(*) filter (where aq.is_correct) / nullif(count(*), 0), 1) as score 
                from public.exam_attempt_questions aq 
                join public.exam_questions q on q.id = aq.question_id 
                where aq.attempt_id = p_attempt 
                group by q.module 
                order by q.module
            ) x
        ), '[]'::jsonb),
        'incorrect_answers', coalesce((
            select jsonb_agg(row_to_json(x) order by question_order) 
            from (
                select aq.question_order, 
                       aq.selected_option, 
                       q.module, 
                       q.question_text, 
                       q.option_a, 
                       q.option_b, 
                       q.option_c, 
                       q.option_d, 
                       q.correct_option, 
                       q.explanation, 
                       q.legal_source, 
                       q.legal_article, 
                       q.legal_reference,
                       q.fundament_type,
                       q.technical_source,
                       q.source_note,
                       q.image_url
                from public.exam_attempt_questions aq 
                join public.exam_questions q on q.id = aq.question_id 
                where aq.attempt_id = p_attempt 
                  and aq.is_correct is false
            ) x
        ), '[]'::jsonb),
        'history', coalesce((
            select jsonb_agg(row_to_json(h) order by h.finished_at desc) 
            from (
                select id, total_score, total_correct, total_questions, finished_at, passed, created_at 
                from public.exam_attempts 
                where user_id = (select user_id from target) 
                  and status = 'completed'
                order by finished_at desc 
                limit 10
            ) h
        ), '[]'::jsonb)
    ) from target);
end; $$;

revoke all on function public.admin_dashboard_data(text) from public;
revoke all on function public.admin_results_page(integer, integer, text, text, text) from public;
revoke all on function public.admin_attempt_detail(uuid) from public;
grant execute on function public.admin_dashboard_data(text) to authenticated;
grant execute on function public.admin_results_page(integer, integer, text, text, text) to authenticated;
grant execute on function public.admin_attempt_detail(uuid) to authenticated;


-- =========================================================
-- 17. RECARGAR CACHÉ DE POSTGREST
-- =========================================================

notify pgrst, 'reload schema';


-- =========================================================
-- 18. COMPROBACIÓN FINAL
-- =========================================================

select
    n.nspname as schema_name,
    p.proname as function_name,
    pg_get_function_identity_arguments(p.oid) as arguments,
    pg_get_function_result(p.oid) as return_type
from pg_proc p
join pg_namespace n
  on n.oid = p.pronamespace
where n.nspname = 'public'
  and p.proname in (
      'start_exam_attempt',
      'save_exam_answer',
      'finish_exam_attempt'
  )
order by p.proname;


-- Ejecutar una vez en Supabase SQL Editor después de actualizar examen.sql.
-- Cancela únicamente intentos vencidos que nunca tuvieron respuesta; no borra
-- datos ni altera resultados finalizados o intentos que sí fueron respondidos.

update public.exam_attempts a
   set status = 'cancelled',
       finished_at = coalesce(a.finished_at, now()),
       duration_seconds = coalesce(
           a.duration_seconds,
           greatest(0, extract(epoch from now() - a.started_at)::integer)
       )
 where a.status = 'in_progress'
   and a.started_at <= now() - interval '40 minutes'
   and not exists (
       select 1
       from public.exam_attempt_questions aq
       where aq.attempt_id = a.id
         and aq.selected_option is not null
   );

-- Revisión: los intentos cancelados no cuentan contra el límite de tres.
select status, count(*) as total
from public.exam_attempts
group by status
order by status;

-- =========================================================
-- LIMPIEZA: eliminar frases pedagógicas de campo explanation
-- y asegurar que cada pregunta tenga su soporte legal.
--
-- Este bloque es idempotente y seguro para ejecutarse en staging.
-- Pasos que realiza:
--   1) PREVIEW: muestra las filas que contienen la frase para revisión.
--   2) Backups: copia las filas afectadas en tablas de respaldo dentro de la BD.
--   3) UPDATE: pone explanation = NULL cuando contiene la frase indeseada
--      y normaliza legal_source/legal_reference SOLO si están vacíos o
--      contienen la referencia pedagógica de Motorland.
--   4) Resultado: devuelve contadores para verificar el cambio.
-- =========================================================

-- PREVIEW: revisar antes de ejecutar los cambios (no modifica nada)
-- SELECT id, question_text, explanation, legal_source, legal_article, legal_reference
-- FROM public.exam_questions
-- WHERE explanation ILIKE '%Respuesta de preparación incluida en el material pedagógico de Motorland%'
-- ORDER BY id
-- LIMIT 200;

-- BEGIN actualización: descomenta y ejecuta cuando estés listo
-- BEGIN;

-- Crear tablas de respaldo (una sola vez por entorno)
create table if not exists public.exam_explanation_fix_backup_questions (like public.exam_questions including all);

-- Insertar en backup únicamente las filas que coinciden (evita duplicados por re-ejecución)
insert into public.exam_explanation_fix_backup_questions
select *
from public.exam_questions q
where q.explanation ilike '%Respuesta de preparación incluida en el material pedagógico de Motorland%'
on conflict do nothing;

-- Valor estándar recomendado para referencia legal si alguna pregunta no tuviera soporte propio.
-- Ajusta la redacción si prefieres otra formulación oficial.
with standard as (
  select 'Manual de referencia para la conducción de vehículos — Agencia Nacional de Seguridad Vial (ANSV)'::text as ansv_ref
)
update public.exam_questions q
set
  explanation = NULL,
  legal_source = case
    when (q.legal_source is null or q.legal_source = '' or q.legal_source ilike '%Motorland%' or q.legal_source ilike '%material pedag%') then standard.ansv_ref
    else q.legal_source
  end,
  legal_reference = case
    when (q.legal_reference is null or q.legal_reference = '' or q.legal_reference ilike '%Motorland%' or q.legal_reference ilike '%material pedag%') then standard.ansv_ref
    else q.legal_reference
  end
from standard
where q.explanation ilike '%Respuesta de preparación incluida en el material pedagógico de Motorland%';

-- Opcional: si hay vistas o tablas que materializan explanation/refs derivados de exam_questions,
-- se verán reflejados automáticamente. La vista public.exam_attempt_review toma los campos
-- directamente de public.exam_questions, por lo que no requiere actualización adicional.

-- Mostrar resumen de cambios
select
  (select count(*) from public.exam_explanation_fix_backup_questions) as backed_up_questions,
  (select count(*) from public.exam_questions where explanation is null and (legal_reference ilike '%ANSV%' or legal_source ilike '%ANSV%')) as questions_now_with_ansv_ref,
  (select count(*) from public.exam_questions where explanation ilike '%Respuesta de preparación incluida en el material pedagógico de Motorland%') as remaining_with_pedagogy_phrase;

-- COMMIT;

-- Nota de seguridad: si necesitas revertir, restaura desde public.exam_explanation_fix_backup_questions:
-- update public.exam_questions q set
--   explanation = b.explanation,
--   legal_source = b.legal_source,
--   legal_article = b.legal_article,
--   legal_reference = b.legal_reference
-- from public.exam_explanation_fix_backup_questions b
-- where q.id = b.id;

-- Fin del bloque de limpieza (ejecutar manualmente en staging).
