document.addEventListener("DOMContentLoaded", async () => {

    /*
    =========================================================
    MOTORLAND CALE
    DASHBOARD DEL ESTUDIANTE
    =========================================================
    */

    const logoutButton =
        document.getElementById("logoutButton");

    const startExamButton =
        document.getElementById("startExamButton");


    /*
    =========================================================
    ELEMENTOS DEL USUARIO
    =========================================================
    */

    const userInitial =
        document.getElementById("userInitial");

    const userName =
        document.getElementById("userName");

    const userCategory =
        document.getElementById("userCategory");

    const welcomeName =
        document.getElementById("welcomeName");

    const dashboardCategory =
        document.getElementById("dashboardCategory");


    /*
    =========================================================
    ELEMENTOS DE INTENTOS
    =========================================================
    */

    const attemptsUsed =
        document.getElementById("attemptsUsed");

    const attemptProgress =
        document.getElementById("attemptProgress");

    const attemptText =
        document.getElementById("attemptText");


    /*
    =========================================================
    ELEMENTOS DE ESTADÍSTICAS
    =========================================================
    */

    const statsEmpty =
        document.getElementById("statsEmpty");

    const statsContent =
        document.getElementById("statsContent");

    const bestScore =
        document.getElementById("bestScore");

    const completedAttempts =
        document.getElementById("completedAttempts");

    const lastResult =
        document.getElementById("lastResult");

    const historyBody =
        document.getElementById("historyBody");


    /*
    =========================================================
    SESIÓN
    =========================================================
    */

    if (
        typeof supabaseClient === "undefined"
    ) {

        console.error(
            "supabaseClient no está disponible."
        );

        return;
    }


    const {
        data: {
            session
        },
        error: sessionError
    } = await supabaseClient.auth.getSession();


    if (
        sessionError ||
        !session
    ) {

        window.location.replace(
            "login.html"
        );

        return;
    }


    const user =
        session.user;


    /*
    =========================================================
    CARGAR PERFIL
    =========================================================
    */

    const {
        data: profile,
        error: profileError
    } = await supabaseClient
        .from("profiles")
        .select(`
            id,
            documento,
            matricula,
            nombres,
            apellidos,
            categoria,
            correo,
            telefono
        `)
        .eq("id", user.id)
        .single();


    if (profileError) {

        console.error(
            "Error cargando perfil:",
            profileError
        );

        mostrarMensajePerfil();

        return;
    }


    /*
    =========================================================
    DATOS DEL ESTUDIANTE
    =========================================================
    */

    const nombre =
        profile.nombres ||
        "Estudiante";

    const apellido =
        profile.apellidos ||
        "";

    const nombreCompleto =
        `${nombre} ${apellido}`.trim();

    const categoria =
        profile.categoria ||
        "—";


    /*
    =========================================================
    MOSTRAR NOMBRE
    =========================================================
    */

    if (userName) {

        userName.textContent =
            nombreCompleto;

    }


    if (welcomeName) {

        welcomeName.textContent =
            nombre;

    }


    if (userInitial) {

        userInitial.textContent =
            nombre
                .charAt(0)
                .toUpperCase();

    }


    /*
    =========================================================
    MOSTRAR CATEGORÍA
    =========================================================
    */

    if (userCategory) {

        userCategory.textContent =
            `Categoría ${categoria}`;

    }


    if (dashboardCategory) {

        dashboardCategory.textContent =
            categoria;

    }


    /*
    =========================================================
    CARGAR INTENTOS
    =========================================================
    */

    await cargarIntentos(
        user.id
    );


    /*
    =========================================================
    BOTÓN INICIAR SIMULADOR
    =========================================================
    */

    if (startExamButton) {

        startExamButton.addEventListener(
            "click",
            async (event) => {

                event.preventDefault();

                const permitidos =
                    await puedeRealizarIntento(
                        user.id
                    );

                if (!permitidos) {

                    mostrarMensajeIntentos();

                    return;
                }

                window.location.href =
                    "examen.html";

            }
        );

    }


    /*
    =========================================================
    CERRAR SESIÓN
    =========================================================
    */

    if (logoutButton) {

        logoutButton.addEventListener(
            "click",
            async () => {

                logoutButton.disabled =
                    true;

                logoutButton.textContent =
                    "Saliendo...";


                const {
                    error
                } =
                    await supabaseClient
                        .auth
                        .signOut();


                if (error) {

                    console.error(
                        "Error cerrando sesión:",
                        error
                    );

                    logoutButton.disabled =
                        false;

                    logoutButton.textContent =
                        "Salir";

                    alert(
                        "No fue posible cerrar la sesión."
                    );

                    return;
                }


                window.location.replace(
                    "login.html"
                );

            }
        );

    }

});



/*
=========================================================
CARGAR INTENTOS
=========================================================
*/

async function cargarIntentos(
    userId
) {

    const attemptsUsed =
        document.getElementById(
            "attemptsUsed"
        );

    const attemptProgress =
        document.getElementById(
            "attemptProgress"
        );

    const attemptText =
        document.getElementById(
            "attemptText"
        );


    /*
    ---------------------------------------------------------
    Mientras creamos la tabla definitiva de intentos,
    comprobamos si existe.
    ---------------------------------------------------------
    */

    const {
        data,
        error
    } = await supabaseClient
        .from("exam_attempts")
        .select(`
            id,
            total_score,
            passed,
            status,
            finished_at,
            created_at
        `)
            .eq("user_id", userId)
            .eq("status", "completed")
        .order(
            "created_at",
            {
                ascending: false
            }
        );


    /*
    ---------------------------------------------------------
    Si todavía no existe la tabla, no rompemos
    el dashboard.
    ---------------------------------------------------------
    */

    if (error) {

        console.warn(
            "No fue posible consultar exam_attempts:",
            error.message
        );

        actualizarIntentos(
            0,
            []
        );

        return;
    }


    actualizarIntentos(
        data?.length || 0,
        data || []
    );

}



/*
=========================================================
ACTUALIZAR INTERFAZ DE INTENTOS
=========================================================
*/

function actualizarIntentos(
    usados,
    resultados
) {

    const MAX_INTENTOS =
        3;


    const attemptsUsed =
        document.getElementById(
            "attemptsUsed"
        );

    const attemptProgress =
        document.getElementById(
            "attemptProgress"
        );

    const attemptText =
        document.getElementById(
            "attemptText"
        );


    if (attemptsUsed) {

        attemptsUsed.textContent =
            usados;

    }


    if (attemptProgress) {

        const porcentaje =
            Math.min(
                (usados / MAX_INTENTOS) * 100,
                100
            );

        attemptProgress.style.width =
            `${porcentaje}%`;

    }


    if (attemptText) {

        const disponibles =
            Math.max(
                MAX_INTENTOS - usados,
                0
            );


        if (disponibles === 0) {

            attemptText.textContent =
                "Has utilizado tus 3 intentos disponibles.";

        } else if (disponibles === 1) {

            attemptText.textContent =
                "Tienes 1 intento disponible.";

        } else {

            attemptText.textContent =
                `Tienes ${disponibles} intentos disponibles.`;

        }

    }


    actualizarEstadisticas(
        resultados
    );

}



/*
=========================================================
ESTADÍSTICAS
=========================================================
*/

function actualizarEstadisticas(
    resultados
) {

    const statsEmpty =
        document.getElementById(
            "statsEmpty"
        );

    const statsContent =
        document.getElementById(
            "statsContent"
        );

    const bestScore =
        document.getElementById(
            "bestScore"
        );

    const completedAttempts =
        document.getElementById(
            "completedAttempts"
        );

    const lastResult =
        document.getElementById(
            "lastResult"
        );


    if (!resultados.length) {

        if (statsEmpty) {

            statsEmpty.classList.remove(
                "hidden"
            );

        }

        if (statsContent) {

            statsContent.classList.add(
                "hidden"
            );

        }

        cargarHistorial([]);

        return;
    }


    if (statsEmpty) {

        statsEmpty.classList.add(
            "hidden"
        );

    }


    if (statsContent) {

        statsContent.classList.remove(
            "hidden"
        );

    }


    const scores =
        resultados
            .map(
                resultado =>
                    Number(
                        resultado.total_score
                    )
            )
            .filter(
                score =>
                    !Number.isNaN(score)
            );


    const mejor =
        scores.length
            ? Math.max(...scores)
            : 0;


    if (bestScore) {

        bestScore.textContent =
            `${mejor}%`;

    }


    if (completedAttempts) {

        completedAttempts.textContent =
            resultados.length;

    }


    const ultimo =
        resultados[0];


    if (lastResult) {

        if (
            ultimo &&
            ultimo.total_score !== null
        ) {

            lastResult.textContent =
                `${ultimo.total_score}%`;

        } else {

            lastResult.textContent =
                "—";

        }

    }


    cargarHistorial(
        resultados
    );

}



/*
=========================================================
HISTORIAL
=========================================================
*/

function cargarHistorial(
    resultados
) {

    const historyBody =
        document.getElementById(
            "historyBody"
        );


    if (!historyBody) {
        return;
    }


    if (!resultados.length) {

        historyBody.innerHTML = `
            <tr class="empty-row">
                <td colspan="5">
                    <div>
                        <span>
                            No hay intentos registrados
                        </span>

                        <small>
                            Tus resultados aparecerán aquí.
                        </small>
                    </div>
                </td>
            </tr>
        `;

        return;
    }


    historyBody.innerHTML =
        resultados
            .map(
                (resultado, index) => {

                    const fecha =
                        new Date(
                            resultado.finished_at || resultado.created_at
                        );


                    const fechaTexto =
                        fecha.toLocaleDateString(
                            "es-CO",
                            {
                                day: "2-digit",
                                month: "2-digit",
                                year: "numeric"
                            }
                        );


                    const estado =
                        resultado.passed
                            ? "Aprobado"
                            : "No aprobado";


                    return `
                        <tr>

                            <td>
                                ${resultados.length - index}
                            </td>

                            <td>
                                ${fechaTexto}
                            </td>

                            <td>
                                ${estado}
                            </td>

                            <td>
                                ${resultado.total_score ?? "—"}%
                            </td>

                            <td>
                                <a
                                    href="resultado.html?id=${resultado.id}"
                                    class="small-link"
                                >
                                    Ver resultado
                                </a>
                            </td>

                        </tr>
                    `;

                }
            )
            .join("");

}



/*
=========================================================
VALIDAR INTENTOS
=========================================================
*/

async function puedeRealizarIntento(
    userId
) {

    const {
        count,
        error
    } = await supabaseClient
        .from("exam_attempts")
        .select(
            "id",
            {
                count: "exact",
                head: true
            }
        )
        .eq(
            "user_id",
            userId
        )
        .eq("status", "completed");


    if (error) {

        console.warn(
            "No fue posible validar los intentos:",
            error.message
        );

        /*
        En desarrollo permitimos continuar.
        Cuando la tabla definitiva esté creada,
        esta validación será obligatoria.
        */

        return true;
    }


    return (
        (count || 0) < 3
    );

}



/*
=========================================================
MENSAJES
=========================================================
*/

function mostrarMensajeIntentos() {

    alert(
        "Has utilizado los 3 intentos disponibles."
    );

}


function mostrarMensajePerfil() {

    alert(
        "No fue posible cargar la información de tu perfil."
    );

}
