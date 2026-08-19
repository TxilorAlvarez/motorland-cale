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
- Límite de 40 minutos y cierre automático
- Distribución CALE: 12 actitudes, 10 movilidad segura y 6 por cada módulo restante

## Puesta en marcha con Supabase

Ejecuta estos archivos en el SQL Editor, en este orden:

1. `supabase/schema.sql`
2. `supabase/examen.sql`
3. `supabase/examen_bank.sql`

Si el navegador muestra `Could not find the function public.save_exam_answer`, ejecuta adicionalmente `supabase/hotfix_save_exam_answer.sql`. El archivo recrea la función que guarda respuestas y solicita a PostgREST recargar su caché de esquema.

`examen_bank.sql` carga 210 preguntas pedagógicas de preparación. No reproduce ni afirma ser el banco oficial del CALE. Los scripts anteriores `preguntas_a2.sql` y `examen_seed.sql` se conservan como material histórico y no deben ejecutarse junto con el banco consolidado.

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
```

## Administrador

El mismo inicio de sesión dirige según `profiles.role`: `student` al panel del aprendiz y `admin`/`superadmin` al panel administrativo. La autorización se comprueba en Supabase y las consultas administrativas son RPC protegidas; no hay credenciales ni roles en el frontend.

Para crear el primer administrador: crea su usuario en **Authentication → Users** de Supabase, copia el UUID y, después de ejecutar `schema.sql`, usa en SQL Editor:

```sql
update public.profiles set role = 'admin' where id = 'UUID_DEL_USUARIO';
```

No existe registro público de administradores. Ejecuta `schema.sql`, luego `examen.sql` y por último `examen_bank.sql` al desplegar una base nueva; en una base existente vuelve a ejecutar los dos primeros para aplicar los roles, las políticas y las RPC administrativas.

## Envío del resultado por correo

El botón **Enviar PDF** de la ficha del aprendiz invoca la Edge Function
`email-attempt-pdf`. La función valida que quien la solicita sea administrador,
genera el PDF en el servidor y lo envía al correo almacenado en `profiles.correo`.
Nunca expone la clave del proveedor de correo en el navegador.

Antes de habilitarlo, configura los secretos y despliega la función:

```bash
supabase secrets set RESEND_API_KEY=... RESULTS_EMAIL_FROM='CEA Motorland <resultados@tu-dominio.com>'
supabase functions deploy email-attempt-pdf
```

Después de ejecutar los scripts SQL, corre `supabase/verify_exam_content.sql` en
el SQL Editor. Solo publica el banco cuando esa verificación devuelva al menos
12 preguntas de actitudes, 10 de movilidad segura y 6 de cada módulo restante
por categoría, y ninguna ruta de imagen fuera de `/assets/images/`.
