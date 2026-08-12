
document.addEventListener("DOMContentLoaded", () => {

    // =========================================================
    // MOSTRAR / OCULTAR CONTRASEÑA
    // =========================================================

    const passwordToggles =
        document.querySelectorAll(".password-toggle");

    passwordToggles.forEach((button) => {

        button.addEventListener("click", () => {

            const targetId =
                button.dataset.target;

            const input =
                document.getElementById(targetId);

            if (!input) return;

            if (input.type === "password") {

                input.type = "text";
                button.textContent = "Ocultar";

            } else {

                input.type = "password";
                button.textContent = "Ver";

            }

        });

    });


    // =========================================================
    // REGISTRO
    // =========================================================

    const registerForm =
        document.getElementById("registerForm");

    if (registerForm) {

        registerForm.addEventListener("submit", async (event) => {

            event.preventDefault();

            const message =
                document.getElementById("registerMessage");

            const submitButton =
                registerForm.querySelector('button[type="submit"]');


            // -------------------------------------------------
            // CAMPOS DEL HTML REAL
            // -------------------------------------------------

            const nombre =
                document.getElementById("nombre")?.value.trim();

            const apellido =
                document.getElementById("apellido")?.value.trim();

            const documento =
                document.getElementById("documento")?.value.trim();

            const matricula =
                document.getElementById("matricula")?.value.trim();

            const categoria =
                document.getElementById("categoria")?.value;

            const email =
                document.getElementById("email")?.value.trim();

            const telefono =
                document.getElementById("telefono")?.value.trim();

            const password =
                document.getElementById("password")?.value;

            const terms =
                document.getElementById("terms")?.checked;


            // -------------------------------------------------
            // VALIDACIONES
            // -------------------------------------------------

            if (
                !nombre ||
                !apellido ||
                !documento ||
                !matricula ||
                !categoria ||
                !email ||
                !password
            ) {

                showMessage(
                    message,
                    "Completa todos los campos obligatorios.",
                    "error"
                );

                return;
            }


            if (!terms) {

                showMessage(
                    message,
                    "Debes aceptar los términos y condiciones para continuar.",
                    "error"
                );

                return;
            }


            if (password.length < 6) {

                showMessage(
                    message,
                    "La contraseña debe tener al menos 6 caracteres.",
                    "error"
                );

                return;
            }


            // -------------------------------------------------
            // BLOQUEAR BOTÓN
            // -------------------------------------------------

            setButtonLoading(
                submitButton,
                true,
                "Creando cuenta..."
            );

            hideMessage(message);


            try {

                // -------------------------------------------------
                // SUPABASE AUTH
                // -------------------------------------------------

                const {
                    data,
                    error
                } = await window.supabaseClient.auth.signUp({

                    email: email,

                    password: password,

                    options: {

                        data: {

                            nombre: nombre,

                            apellido: apellido,

                            documento: documento,

                            matricula: matricula,

                            categoria: categoria,

                            telefono: telefono || "",

                            terms_accepted: terms

                        }

                    }

                });


                // -------------------------------------------------
                // ERROR
                // -------------------------------------------------

                if (error) {

                    console.error(
                        "Error Supabase:",
                        error
                    );

                    showMessage(
                        message,
                        translateAuthError(error),
                        "error"
                    );

                    return;
                }


                // -------------------------------------------------
                // REGISTRO EXITOSO
                // -------------------------------------------------

                console.log(
                    "Usuario creado:",
                    data.user
                );


                /*
                 * Si la confirmación de correo está desactivada
                 * en Supabase, tendremos sesión inmediatamente.
                 */

                if (data.session) {

                    showMessage(
                        message,
                        "Cuenta creada correctamente. Redirigiendo...",
                        "success"
                    );

                    setTimeout(() => {

                        window.location.href =
                            "dashboard.html";

                    }, 1000);

                    return;
                }


                /*
                 * Si la confirmación de correo está activada,
                 * Supabase crea el usuario pero no entrega sesión.
                 */

                showMessage(
                    message,
                    "Cuenta creada. Revisa tu correo para continuar.",
                    "success"
                );

            } catch (error) {

                console.error(
                    "Error inesperado:",
                    error
                );

                showMessage(
                    message,
                    "Ocurrió un error inesperado. Intenta nuevamente.",
                    "error"
                );

            } finally {

                setButtonLoading(
                    submitButton,
                    false
                );

            }

        });

    }


    // =========================================================
    // LOGIN
    // =========================================================

    const loginForm =
        document.getElementById("loginForm");

    if (loginForm) {

        loginForm.addEventListener("submit", async (event) => {

            event.preventDefault();

            const message =
                document.getElementById("loginMessage");

            const submitButton =
                loginForm.querySelector('button[type="submit"]');


            // -------------------------------------------------
            // CAMPOS DEL HTML REAL
            // -------------------------------------------------

            const email =
                document.getElementById("loginEmail")?.value.trim();

            const password =
                document.getElementById("loginPassword")?.value;


            // -------------------------------------------------
            // VALIDACIÓN
            // -------------------------------------------------

            if (!email || !password) {

                showMessage(
                    message,
                    "Ingresa tu correo electrónico y contraseña.",
                    "error"
                );

                return;
            }


            setButtonLoading(
                submitButton,
                true,
                "Ingresando..."
            );

            hideMessage(message);


            try {

                const {
                    data,
                    error
                } = await window.supabaseClient.auth
                    .signInWithPassword({

                        email: email,

                        password: password

                    });


                if (error) {

                    console.error(
                        "Error de login:",
                        error
                    );

                    showMessage(
                        message,
                        translateAuthError(error),
                        "error"
                    );

                    return;
                }


                console.log(
                    "Sesión iniciada:",
                    data.user
                );


                showMessage(
                    message,
                    "Ingreso exitoso. Redirigiendo...",
                    "success"
                );


                setTimeout(() => {

                    window.location.href =
                        "dashboard.html";

                }, 700);


            } catch (error) {

                console.error(
                    "Error inesperado:",
                    error
                );

                showMessage(
                    message,
                    "Ocurrió un error inesperado. Intenta nuevamente.",
                    "error"
                );

            } finally {

                setButtonLoading(
                    submitButton,
                    false
                );

            }

        });

    }


    // =========================================================
    // RECUPERAR CONTRASEÑA
    // =========================================================

    const forgotPassword =
        document.getElementById("forgotPassword");

    if (forgotPassword) {

        forgotPassword.addEventListener("click", async (event) => {

            event.preventDefault();

            const email =
                document.getElementById("loginEmail")?.value.trim();


            if (!email) {

                alert(
                    "Escribe primero tu correo electrónico."
                );

                return;
            }


            try {

                const {
                    error
                } = await window.supabaseClient.auth
                    .resetPasswordForEmail(
                        email,
                        {
                            redirectTo:
                                `${window.location.origin}/motorland-cale/login.html`
                        }
                    );


                if (error) {

                    console.error(
                        "Error recuperación:",
                        error
                    );

                    alert(
                        translateAuthError(error)
                    );

                    return;
                }


                alert(
                    "Si el correo está registrado, recibirás las instrucciones para recuperar tu contraseña."
                );

            } catch (error) {

                console.error(
                    "Error inesperado:",
                    error
                );

                alert(
                    "No fue posible iniciar la recuperación de contraseña."
                );

            }

        });

    }

});


// =========================================================
// MENSAJES
// =========================================================

function showMessage(element, text, type) {

    if (!element) return;

    element.className =
        `form-message show ${type}`;

    element.textContent =
        text;
}


function hideMessage(element) {

    if (!element) return;

    element.className =
        "form-message";

    element.textContent =
        "";
}


// =========================================================
// ESTADO DEL BOTÓN
// =========================================================

function setButtonLoading(
    button,
    loading,
    text = "Continuar"
) {

    if (!button) return;

    if (loading) {

        button.dataset.originalText =
            button.textContent;

        button.disabled =
            true;

        button.textContent =
            text;

    } else {

        button.disabled =
            false;

        button.textContent =
            button.dataset.originalText ||
            "Continuar";

    }

}


// =========================================================
// MENSAJES DE ERROR AMIGABLES
// =========================================================

function translateAuthError(error) {

    const message =
        error?.message?.toLowerCase() || "";


    if (
        message.includes("user already registered") ||
        message.includes("already registered")
    ) {

        return "Este correo electrónico ya está registrado. Intenta iniciar sesión.";
    }


    if (
        message.includes("invalid login credentials")
    ) {

        return "El correo o la contraseña son incorrectos.";
    }


    if (
        message.includes("email not confirmed")
    ) {

        return "Debes confirmar tu correo electrónico antes de ingresar.";
    }


    if (
        message.includes("password should be at least")
    ) {

        return "La contraseña no cumple con la longitud mínima.";
    }


    if (
        message.includes("invalid email")
    ) {

        return "Ingresa un correo electrónico válido.";
    }


    if (
        message.includes("rate limit")
    ) {

        return "Se han realizado demasiados intentos. Espera unos minutos e inténtalo nuevamente.";
    }


    return (
        error?.message ||
        "No fue posible completar la operación."
    );

}