/**
 * =========================================================
 * MOTORLAND CALE
 * ADMIN AUTH
 * =========================================================
 *
 * Validación básica de sesión administrativa.
 *
 * IMPORTANTE:
 * La autorización definitiva del administrador debe quedar
 * protegida también en Supabase mediante RLS/roles.
 * Este archivo NO debe considerarse una barrera de seguridad
 * por sí solo.
 * =========================================================
 */

document.addEventListener("DOMContentLoaded", inicializarAdminAuth);

async function inicializarAdminAuth() {
    try {
        if (!window.supabaseClient) {
            console.error("supabaseClient no está disponible.");
            mostrarErrorAdmin("No fue posible conectar con Supabase.");
            return;
        }

        const {
            data: {
                session
            },
            error
        } = await window.supabaseClient.auth.getSession();

        if (error) {
            console.error("Error obteniendo sesión:", error);
            mostrarErrorAdmin("No fue posible validar la sesión.");
            return;
        }

        if (!session) {
            window.location.replace("../login.html");
            return;
        }

        await validarAdministrador(session);
        configurarLogoutAdmin();

    } catch (error) {
        console.error(
            "Error inesperado en admin-auth:",
            error
        );

        mostrarErrorAdmin(
            "Ocurrió un error al validar el acceso."
        );
    }
}


/* =========================================================
   VALIDAR ADMINISTRADOR
   ========================================================= */

async function validarAdministrador(session) {

    const { data: profile, error } = await window.supabaseClient
        .from("profiles")
        .select("nombres,apellidos,correo,role")
        .eq("id", session.user.id)
        .single();

    if (error || !["admin", "superadmin"].includes(profile?.role)) {
        window.location.replace("../dashboard.html");
        return;
    }

    window.adminSession = session;

    const adminName =
        document.getElementById("adminName");

    const adminEmail =
        document.getElementById("adminEmail");

    if (adminEmail) {
        adminEmail.textContent =
            session.user.email || "Administrador";
    }

    if (adminName) {
        adminName.textContent =
            `${profile.nombres || ""} ${profile.apellidos || ""}`.trim() ||
            session.user.email?.split("@")[0] ||
            "Administrador";
    }

    document.body.classList.add("admin-authenticated");
}


/* =========================================================
   LOGOUT
   ========================================================= */

function configurarLogoutAdmin() {

    const buttons =
        document.querySelectorAll(
            "[data-admin-logout], #adminLogout, #logoutButton"
        );

    buttons.forEach(button => {

        button.addEventListener(
            "click",
            cerrarSesionAdmin
        );

    });
}


async function cerrarSesionAdmin() {

    try {

        const {
            error
        } = await window.supabaseClient.auth.signOut();

        if (error) {
            console.error(
                "Error cerrando sesión:",
                error
            );

            return;
        }

        window.location.replace(
            "../login.html"
        );

    } catch (error) {

        console.error(
            "Error inesperado cerrando sesión:",
            error
        );

    }
}


/* =========================================================
   UTILIDAD ERROR
   ========================================================= */

function mostrarErrorAdmin(mensaje) {

    console.error(mensaje);

    const element =
        document.getElementById(
            "adminError"
        );

    if (element) {
        element.textContent = mensaje;
        element.classList.remove("hidden");
        return;
    }

    /*
     * No usamos alert() automáticamente para no romper
     * la experiencia visual del dashboard.
     */
}


/* =========================================================
   UTILIDADES GLOBALES
   ========================================================= */

window.AdminAuth = {

    getSession: () =>
        window.adminSession || null,

    logout: cerrarSesionAdmin

};
