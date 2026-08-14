-- =========================================================
-- MOTORLAND CALE
-- PRIMER ESQUEMA DE BASE DE DATOS
-- Registro y perfil del estudiante
-- =========================================================


-- =========================================================
-- TABLA DE PERFILES
-- =========================================================

create table if not exists public.profiles (

    id uuid primary key
        references auth.users(id)
        on delete cascade,

    documento text not null unique,

    matricula text not null unique,

    nombres text not null,

    apellidos text not null,

    categoria text not null
        check (categoria in ('A2', 'B1', 'C1')),

    role text not null default 'student'
        check (role in ('student', 'admin', 'superadmin')),

    correo text not null,

    telefono text,

    consentimiento_datos boolean not null default false,

    consentimiento_at timestamptz,

    created_at timestamptz not null default now(),

    updated_at timestamptz not null default now()
);

alter table public.profiles
    add column if not exists role text not null default 'student'
        check (role in ('student', 'admin', 'superadmin'));


-- =========================================================
-- FUNCIÓN PARA CREAR AUTOMÁTICAMENTE EL PERFIL
-- CUANDO SE CREA UN USUARIO EN SUPABASE AUTH
-- =========================================================

create or replace function public.handle_new_user()

returns trigger

language plpgsql

security definer

set search_path = public

as $$

begin

    insert into public.profiles (

        id,

        documento,

        matricula,

        nombres,

        apellidos,

        categoria,

        correo,

        telefono,

        consentimiento_datos,

        consentimiento_at

    )

    values (

        new.id,

        new.raw_user_meta_data ->> 'documento',

        new.raw_user_meta_data ->> 'matricula',

        new.raw_user_meta_data ->> 'nombre',

        new.raw_user_meta_data ->> 'apellido',

        new.raw_user_meta_data ->> 'categoria',

        new.email,

        nullif(
            new.raw_user_meta_data ->> 'telefono',
            ''
        ),

        coalesce(

            (
                new.raw_user_meta_data
                ->> 'terms_accepted'
            )::boolean,

            false

        ),

        case

            when coalesce(

                (
                    new.raw_user_meta_data
                    ->> 'terms_accepted'
                )::boolean,

                false

            )

            then now()

            else null

        end

    );

    return new;

end;

$$;


-- =========================================================
-- TRIGGER
-- =========================================================

drop trigger if exists on_auth_user_created
on auth.users;


create trigger on_auth_user_created

after insert on auth.users

for each row

execute procedure public.handle_new_user();


-- =========================================================
-- SEGURIDAD RLS
-- =========================================================

alter table public.profiles
enable row level security;

-- La autorización administrativa depende de Supabase, nunca del frontend.
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
    select exists (
        select 1
        from public.profiles
        where id = auth.uid()
          and role in ('admin', 'superadmin')
    );
$$;

revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to authenticated;


-- =========================================================
-- POLÍTICA DE LECTURA
-- Cada estudiante solamente puede consultar SU perfil.
-- =========================================================

drop policy if exists "Users can view own profile"
on public.profiles;

drop policy if exists "Users can view own or admin profile"
on public.profiles;


create policy "Users can view own or admin profile"

on public.profiles

for select

to authenticated

using (
    (select auth.uid()) = id
    or public.is_admin()
);


-- =========================================================
-- POLÍTICA DE ACTUALIZACIÓN
-- Cada estudiante solamente puede actualizar SU perfil.
-- =========================================================

drop policy if exists "Users can update own profile"
on public.profiles;


create policy "Users can update own profile"

on public.profiles

for update

to authenticated

using (
    (select auth.uid()) = id
)

with check (
    (select auth.uid()) = id
);


-- =========================================================
-- PERMISOS
-- =========================================================

revoke update on public.profiles from authenticated;

grant select on public.profiles to authenticated;

-- Ningún usuario autenticado puede escalar su rol desde el navegador.
grant update (nombres, apellidos, correo, telefono)
on public.profiles to authenticated;


-- =========================================================
-- ÍNDICES
-- =========================================================

create index if not exists profiles_documento_idx

on public.profiles(documento);


create index if not exists profiles_matricula_idx

on public.profiles(matricula);


create index if not exists profiles_categoria_idx

on public.profiles(categoria);

-- El esquema base termina aquí. La estructura y las políticas del
-- simulador viven en supabase/examen.sql para evitar dos definiciones
-- incompatibles de exam_attempts.
