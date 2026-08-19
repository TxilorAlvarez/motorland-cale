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
