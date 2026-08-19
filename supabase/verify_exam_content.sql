-- Ejecutar DESPUÉS de cargar examen.sql y examen_bank.sql.
-- No modifica datos: confirma que Supabase puede leer el banco y las imágenes.

-- La selección del simulador requiere esta distribución para cada categoría.
select
  category_name as category,
  coalesce(count(*) filter (where q.module = 'attitudes'), 0) as attitudes,
  coalesce(count(*) filter (where q.module = 'safe_mobility'), 0) as safe_mobility,
  coalesce(count(*) filter (where q.module = 'traffic_rules'), 0) as traffic_rules,
  coalesce(count(*) filter (where q.module = 'signage_infrastructure'), 0) as signage_infrastructure,
  coalesce(count(*) filter (where q.module = 'vehicle'), 0) as vehicle,
  coalesce(count(q.id), 0) as total
from unnest(array['A2', 'B1', 'C1', 'GENERAL']::text[]) as category_name
left join public.exam_questions q
  on q.active and q.category @> array[category_name]
group by category_name
order by category_name;

-- Las rutas deben comenzar por /assets/images/ y apuntar a archivos publicados.
select id, question_text, image_url
from public.exam_questions
where image_url is not null
  and image_url !~ '^/assets/images/'
order by created_at;

-- Confirma que el lector del simulador ve las columnas necesarias.
select column_name, data_type
from information_schema.columns
where table_schema = 'public'
  and table_name = 'exam_questions'
  and column_name in ('question_type', 'module', 'category', 'image_url', 'active')
order by column_name;
