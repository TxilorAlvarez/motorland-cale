# Motorland CALE

Simulador de preparación para evaluación teórica.

## Arquitectura inicial

- Frontend: HTML5, CSS3 y JavaScript
- Hosting: GitHub Pages
- Backend/BaaS: Supabase
- Base de datos: PostgreSQL mediante Supabase
- Autenticación: Supabase Auth

## Funcionalidades

- Registro de estudiantes
- Inicio de sesión
- Tres intentos por estudiante
- Banco de preguntas
- Preguntas aleatorias
- Registro de respuestas
- Calificación
- Resultados
- Historial de intentos
- Trazabilidad
- Reanudación del intento en curso, incluso al recargar la página
- Límite de 70 minutos y cierre automático
- Distribución CALE: 12 actitudes, 10 movilidad segura y 6 por cada módulo restante

## Puesta en marcha con Supabase

Ejecuta estos archivos en el SQL Editor, en este orden:

1. `supabase/schema.sql`
2. `supabase/examen.sql`
3. `supabase/examen_bank.sql`

`examen_bank.sql` carga 240 preguntas pedagógicas de preparación: 200 del banco y 40 situacionales. No reproduce ni afirma ser el banco oficial del CALE. Los scripts anteriores `preguntas_a2.sql` y `examen_seed.sql` se conservan como material histórico y no deben ejecutarse junto con el banco consolidado.

Para regenerar el banco desde los PDF extraídos a texto:

```bash
pdftotext -layout /ruta/Banco_200_Preguntas_CALE_CEA_Motorland.pdf /tmp/banco.txt
pdftotext -layout /ruta/40_Preguntas_Situacionales_Tipo_CALE_Motorland.pdf /tmp/situacionales.txt
node tools/generate_exam_bank.mjs /tmp/banco.txt /tmp/situacionales.txt supabase/examen_bank.sql
```

## Estructura

```text
frontend/    Aplicación web
supabase/    Base de datos y configuración
