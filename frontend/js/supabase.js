/**
 * Cliente Supabase
 * Motorland CALE
 */

if (!window.SUPABASE_URL) {
    throw new Error("SUPABASE_URL no está configurada.");
}

if (!window.SUPABASE_PUBLISHABLE_KEY) {
    throw new Error("SUPABASE_PUBLISHABLE_KEY no está configurada.");
}

if (!window.supabase) {
    throw new Error("La librería de Supabase no fue cargada.");
}

window.supabaseClient = window.supabase.createClient(
    window.SUPABASE_URL,
    window.SUPABASE_PUBLISHABLE_KEY
);

console.log("Supabase conectado correctamente.");
