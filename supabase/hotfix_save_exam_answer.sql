-- Hotfix para proyectos donde PostgREST no reconoce save_exam_answer.
-- Ejecutar una vez en Supabase SQL Editor con una cuenta administradora.

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

    if p_option not in ('A', 'B', 'C', 'D') then
        raise exception 'Respuesta inválida';
    end if;

    update public.exam_attempt_questions as assigned_question
       set selected_option = p_option,
           answered_at = now()
      from public.exam_attempts as attempt
     where assigned_question.attempt_id = attempt.id
       and assigned_question.attempt_id = p_attempt
       and assigned_question.question_order = p_order
       and attempt.user_id = auth.uid()
       and attempt.status = 'in_progress'
       and attempt.started_at > now() - interval '70 minutes';

    if not found then
        raise exception 'No se puede actualizar esta respuesta';
    end if;
end;
$$;

revoke all on function public.save_exam_answer(uuid, integer, text) from public;
grant execute on function public.save_exam_answer(uuid, integer, text) to authenticated;

-- PostgREST suele actualizar el caché solo, pero esta notificación lo fuerza.
notify pgrst, 'reload schema';

-- Comprobación: debe devolver una fila con argument_names {p_attempt,p_order,p_option}.
select routine_name, routine_schema, parameter_name, data_type
from information_schema.parameters
where specific_schema = 'public'
  and specific_name like 'save_exam_answer%'
order by ordinal_position;
