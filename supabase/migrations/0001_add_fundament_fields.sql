-- Migration: add fields to exam_questions to support structured foundations
-- NOT APPLIED: review before executing in your Supabase SQL editor

alter table if exists public.exam_questions
    add column if not exists fundament_type text;

alter table if exists public.exam_questions
    add column if not exists technical_source text;

alter table if exists public.exam_questions
    add column if not exists source_note text;

-- Optional: constrain fundament_type to known values
create type if not exists public.fundament_kind as enum ('juridico','tecnico','pedagogico','mixto');

-- Safely try to set the column to the enum type, defaulting to pedagogico when empty
-- This step is optional; review before running in production.
-- alter table if exists public.exam_questions
--     alter column fundament_type type public.fundament_kind using (coalesce(fundament_type::text, 'pedagogico')::public.fundament_kind);

-- Example update statements (do not run until you verified sources):
-- update public.exam_questions set fundament_type='tecnico', technical_source='Manual ANSV 2026' where id = '<uuid>';
