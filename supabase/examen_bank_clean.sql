-- examen_bank_clean.sql
-- Script único para limpiar el banco de preguntas: consolida duplicados, unifica categorías y normaliza metadatos/imágenes.
-- Aplicar UNA sola vez en el entorno de base de datos (p. ej. psql o cliente supabase). No es una "migración" en el pipeline.

BEGIN;

-- Respaldo de la tabla completa (si no existe)
CREATE TABLE IF NOT EXISTS public.exam_questions_backup AS TABLE public.exam_questions WITH NO DATA;
INSERT INTO public.exam_questions_backup SELECT * FROM public.exam_questions;

-- Normalización por texto base y selección del registro más reciente como guardián
WITH normalized AS (
  SELECT id, category, image_url, explanation, legal_reference, question_text,
         lower(regexp_replace(question_text, '[^[:alnum:]\sáéíóúñÁÉÍÓÚÑüÜ]', ' ', 'g')) AS base_text
  FROM public.exam_questions
),
groups AS (
  SELECT base_text, array_agg(id ORDER BY created_at DESC, id DESC) AS ids, count(*) AS cnt
  FROM normalized
  GROUP BY base_text
  HAVING count(*) > 1
),
to_keep AS (
  SELECT base_text, ids[1] AS keeper_id, ids AS all_ids
  FROM groups
)

-- Unir categorías y traer primeros metadatos disponibles al keeper
UPDATE public.exam_questions q
SET category = sub.new_cat,
    image_url = COALESCE(q.image_url, sub.any_image),
    explanation = COALESCE(q.explanation, sub.any_expl),
    legal_reference = COALESCE(q.legal_reference, sub.any_legal),
    active = true
FROM (
  SELECT t.keeper_id,
         (
           SELECT array_agg(DISTINCT x)
           FROM (
             SELECT unnest(q2.category) AS x
             FROM public.exam_questions q2
             WHERE q2.id = ANY(t.all_ids)
           ) s
         ) AS new_cat,
         (
           SELECT q3.image_url FROM public.exam_questions q3 WHERE q3.id = ANY(t.all_ids) AND q3.image_url IS NOT NULL LIMIT 1
         ) AS any_image,
         (
           SELECT q4.explanation FROM public.exam_questions q4 WHERE q4.id = ANY(t.all_ids) AND q4.explanation IS NOT NULL LIMIT 1
         ) AS any_expl,
         (
           SELECT q5.legal_reference FROM public.exam_questions q5 WHERE q5.id = ANY(t.all_ids) AND q5.legal_reference IS NOT NULL LIMIT 1
         ) AS any_legal
  FROM to_keep t
) AS sub
WHERE q.id = sub.keeper_id;

-- Desactivar las copias redundantes (dejar solo el keeper activo)
WITH normalized AS (
  SELECT id, lower(regexp_replace(question_text, '[^[:alnum:]\sáéíóúñÁÉÍÓÚÑüÜ]', ' ', 'g')) AS base_text
  FROM public.exam_questions
),
groups AS (
  SELECT base_text, array_agg(id ORDER BY created_at DESC, id DESC) AS ids
  FROM normalized
  GROUP BY base_text
  HAVING count(*) > 1
),
to_keep AS (
  SELECT base_text, ids[1] AS keeper_id, ids AS all_ids
  FROM groups
)
UPDATE public.exam_questions q
SET active = false
FROM to_keep t
WHERE q.id = ANY(t.all_ids)
  AND q.id <> t.keeper_id;

-- Normalizaciones de rutas conocidas (aplica correcciones de extensiones/nombres detectadas)
UPDATE public.exam_questions
SET image_url = CASE image_url
  WHEN '/assets/images/signals/SR-01.png' THEN '/assets/images/signals/SR-01.jpg'
  WHEN '/assets/images/signals/SR-30_50.png' THEN '/assets/images/signals/SR-30_50.jpeg'
  WHEN '/assets/images/signals/SR-30_30.png' THEN '/assets/images/signals/SR-30_30.jpeg'
  WHEN '/assets/images/illustrations/a2_prenda_reflectiva.png' THEN '/assets/images/illustrations/a2_chaleco_reflectivo_horario.jpeg'
  WHEN '/assets/images/illustrations/b1_cinturon_ocupantes.png' THEN '/assets/images/illustrations/b1_cinturon_ocupantes.jpg'
  WHEN '/assets/images/signals/demarcacion_amarilla_continua.lpeg' THEN '/assets/images/signals/demarcacion_amarilla_continua.jpeg'
  WHEN '/assets/images/illustrations/a2_tecnica_mirada_curva.png' THEN '/assets/images/illustrations/a2_tecnica_mirada_curva.jpg'
  WHEN '/assets/images/illustrations/a2_reaccion_aceite.jpg' THEN '/assets/images/signals/a2_reaccion_aceite.jpg'
  WHEN '/assets/images/signals/prohibicion_carril_exclusivo.png' THEN '/assets/images/signals/prohibicion_carril_exclusivo.jpg'
  WHEN '/assets/images/signals/SI_escudo_ruta_45.png' THEN '/assets/images/signals/SI_escudo_ruta_45.jpeg'
  WHEN '/assets/images/illustrations/a2_rines_reflectivos.png' THEN '/assets/images/illustrations/a2_rines_reflectivos.jpeg'
  WHEN '/assets/images/signals/demarcacion_linea_berma.png' THEN '/assets/images/signals/demarcacion_linea_berma.jpeg'
  WHEN '/assets/images/signals/SP-44.png' THEN '/assets/images/signals/P-44.png'
  ELSE image_url
END
WHERE image_url LIKE '/assets/images/%';

-- Verificación rápida: indicar problemas que requieran revisión manual
-- 1) entradas con image_url que no comiencen por /assets/images/
-- 2) textos duplicados activos (deben quedar 0)

-- NOTIFY pgrst puede ser útil en entornos supabase
NOTIFY pgrst, 'reload schema';

COMMIT;
