document.addEventListener("DOMContentLoaded", () => {

    const options =
        document.querySelectorAll(
            ".answer-option"
        );

    const nextButton =
        document.getElementById(
            "nextQuestion"
        );

    const previousButton =
        document.getElementById(
            "previousQuestion"
        );

    let selectedAnswer = null;


    options.forEach((option) => {

        option.addEventListener(
            "click",
            () => {

                options.forEach((item) => {
                    item.classList.remove(
                        "selected"
                    );
                });

                option.classList.add(
                    "selected"
                );

                selectedAnswer = option;

                const status =
                    document.querySelector(
                        ".question-status"
                    );

                if (status) {

                    status.textContent =
                        "Respuesta seleccionada";

                }

            }
        );

    });


    if (nextButton) {

        nextButton.addEventListener(
            "click",
            () => {

                if (!selectedAnswer) {

                    const status =
                        document.querySelector(
                            ".question-status"
                        );

                    if (status) {

                        status.textContent =
                            "Selecciona una respuesta para continuar";

                    }

                    return;

                }

                alert(
                    "La navegación entre preguntas se conectará al banco de preguntas en Supabase."
                );

            }
        );

    }


    if (previousButton) {

        previousButton.addEventListener(
            "click",
            () => {

                alert(
                    "Esta función se habilitará cuando conectemos el motor del examen."
                );

            }
        );

    }

});