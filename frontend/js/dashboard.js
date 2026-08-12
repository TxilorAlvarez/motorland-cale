document.addEventListener("DOMContentLoaded", () => {

    const logoutButton =
        document.getElementById("logoutButton");

    if (logoutButton) {

        logoutButton.addEventListener(
            "click",
            () => {

                window.location.href =
                    "index.html";

            }
        );

    }


    const startButton =
        document.getElementById(
            "startExamButton"
        );

    if (startButton) {

        startButton.addEventListener(
            "click",
            () => {

                window.location.href =
                    "examen.html";

            }
        );

    }

});