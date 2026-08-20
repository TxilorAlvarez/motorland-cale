-- Expone la corrección y la fuente declarada de cada pregunta terminada.
-- Ejecutar mediante `supabase db push` o en el SQL Editor del proyecto.

alter table public.exam_questions
    add column if not exists fundament_type text,
    add column if not exists technical_source text,
    add column if not exists source_note text;

create or replace view public.exam_attempt_review
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
join public.exam_attempt_questions aq on aq.attempt_id = a.id
join public.exam_questions q on q.id = aq.question_id
where a.status in ('completed', 'expired');

create or replace function public.admin_attempt_detail(p_attempt uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
begin
    if not public.is_admin() then raise exception 'No autorizado' using errcode = '42501'; end if;
    return (with target as (
        select a.*, p.nombres, p.apellidos, p.documento, p.matricula, p.correo, p.telefono
        from public.exam_attempts a join public.profiles p on p.id = a.user_id
        where a.id = p_attempt and a.status in ('completed', 'expired')
    ) select jsonb_build_object(
        'attempt', (select row_to_json(target) from target),
        'modules', coalesce((select jsonb_agg(row_to_json(x)) from (
            select q.module, count(*) as total_questions, count(*) filter (where aq.is_correct) as correct_answers,
                   round(100.0 * count(*) filter (where aq.is_correct) / nullif(count(*), 0), 1) as score
            from public.exam_attempt_questions aq join public.exam_questions q on q.id = aq.question_id
            where aq.attempt_id = p_attempt group by q.module order by q.module
        ) x), '[]'::jsonb),
        'incorrect_answers', coalesce((select jsonb_agg(row_to_json(x) order by question_order) from (
            select aq.question_order, aq.selected_option, q.module, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d,
                   q.correct_option, q.explanation, q.legal_source, q.legal_article, q.legal_reference,
                   q.fundament_type, q.technical_source, q.source_note, q.image_url
            from public.exam_attempt_questions aq join public.exam_questions q on q.id = aq.question_id
            where aq.attempt_id = p_attempt and aq.is_correct is false
        ) x), '[]'::jsonb),
        'history', coalesce((select jsonb_agg(row_to_json(h) order by h.finished_at desc) from (
            select id, total_score, total_correct, total_questions, finished_at, passed, created_at
            from public.exam_attempts where user_id = (select user_id from target)
              and status in ('completed', 'expired') order by finished_at desc limit 10
        ) h), '[]'::jsonb)
    ) from target);
end; $$;

grant select on public.exam_attempt_review to authenticated;
revoke all on function public.admin_attempt_detail(uuid) from public;
grant execute on function public.admin_attempt_detail(uuid) to authenticated;
notify pgrst, 'reload schema';
