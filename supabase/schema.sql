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

    correo text not null,

    telefono text,

    consentimiento_datos boolean not null default false,

    consentimiento_at timestamptz,

    created_at timestamptz not null default now(),

    updated_at timestamptz not null default now()
);


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


-- =========================================================
-- POLÍTICA DE LECTURA
-- Cada estudiante solamente puede consultar SU perfil.
-- =========================================================

drop policy if exists "Users can view own profile"
on public.profiles;


create policy "Users can view own profile"

on public.profiles

for select

to authenticated

using (
    (select auth.uid()) = id
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

grant select, update

on public.profiles

to authenticated;


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
