document.addEventListener("DOMContentLoaded", () => {

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


    const registerForm =
        document.getElementById("registerForm");

    if (registerForm) {

        registerForm.addEventListener(
            "submit",
            (event) => {

                event.preventDefault();

                const message =
                    document.getElementById(
                        "registerMessage"
                    );

                message.className =
                    "form-message show success";

                message.textContent =
                    "Formulario correcto. La conexión con Supabase se activará en el siguiente paso.";

            }
        );

    }


    const loginForm =
        document.getElementById("loginForm");

    if (loginForm) {

        loginForm.addEventListener(
            "submit",
            (event) => {

                event.preventDefault();

                const message =
                    document.getElementById(
                        "loginMessage"
                    );

                message.className =
                    "form-message show success";

                message.textContent =
                    "Formulario correcto. La autenticación con Supabase se activará en el siguiente paso.";

            }
        );

    }


    const forgotPassword =
        document.getElementById(
            "forgotPassword"
        );

    if (forgotPassword) {

        forgotPassword.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                alert(
                    "La recuperación de contraseña se conectará con Supabase."
                );

            }
        );

    }

});