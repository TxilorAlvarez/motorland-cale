let preguntas = [];
let respuestas = [];
let preguntaActual = 0;
let attemptId = null;
let finalizado = false;
let timerId = null;
let guardandoRespuesta = false;

// =========================================================
// INICIO
// =========================================================

document.addEventListener("DOMContentLoaded", iniciar);

// =========================================================
// INICIALIZAR EXAMEN
// =========================================================

async function iniciar() {
    try {
        // -------------------------------------------------
        // SESIÓN
        // -------------------------------------------------

        const {
            data: { session },
            error: sessionError
        } = await supabaseClient.auth.getSession();

        if (sessionError) {
            console.error(
                "Error obteniendo sesión:",
                sessionError
            );

            return mostrarError(
                "No fue posible validar la sesión."
            );
        }

        if (!session) {
            window.location.replace("login.html");
            return;
        }

        // -------------------------------------------------
        // PERFIL
        // -------------------------------------------------

        const {
            data: profile,
            error: profileError
        } = await supabaseClient
            .from("profiles")
            .select("nombres,categoria")
            .eq("id", session.user.id)
            .single();

        if (profileError || !profile) {
            console.error(
                "Error cargando perfil:",
                profileError
            );

            return mostrarError(
                "No fue posible cargar tu perfil de estudiante."
            );
        }

        // -------------------------------------------------
        // CATEGORÍA
        // -------------------------------------------------

        const categoria = String(
            profile.categoria || ""
        )
            .trim()
            .toUpperCase();

        const categoriasPermitidas = [
            "A2",
            "B1",
            "C1"
        ];

        if (!categoriasPermitidas.includes(categoria)) {
            return mostrarError(
                "No fue posible validar tu categoría."
            );
        }

        // -------------------------------------------------
        // PRIMER NOMBRE
        // -------------------------------------------------

        const nombre = String(
            profile.nombres || "Estudiante"
        )
            .trim()
            .split(/\s+/)[0];

        mostrarIdentidad(
            nombre,
            categoria
        );

        // -------------------------------------------------
        // EVENTOS
        // -------------------------------------------------

        configurarEventos();

        // -------------------------------------------------
        // CARGANDO
        // -------------------------------------------------

        mostrarCargando(
            "Preparando tu evaluación..."
        );

        // -------------------------------------------------
        // CREAR INTENTO
        // -------------------------------------------------

        const {
            data: nuevoAttemptId,
            error: startError
        } = await supabaseClient.rpc(
            "start_exam_attempt"
        );

        if (startError) {
            console.error(
                "Error iniciando intento:",
                startError
            );

            return mostrarError(
                "No fue posible iniciar la evaluación. " +
                startError.message
            );
        }

        if (!nuevoAttemptId) {
            return mostrarError(
                "No se recibió el identificador del intento."
            );
        }

        attemptId = nuevoAttemptId;

        console.log(
            "Intento creado:",
            attemptId
        );

        // -------------------------------------------------
        // OBTENER PREGUNTAS ASIGNADAS
        // -------------------------------------------------

        const {
            data: asignadas,
            error: questionsError
        } = await supabaseClient
            .from("exam_attempt_questions")
            .select("question_order,question_id,selected_option")
            .eq("attempt_id", attemptId)
            .order("question_order", {
                ascending: true
            });

        if (questionsError) {
            console.error(
                "Error obteniendo preguntas asignadas:",
                questionsError
            );

            return mostrarError(
                "No fue posible cargar las preguntas asignadas."
            );
        }

        if (
            !asignadas ||
            asignadas.length !== 40
        ) {
            console.error(
                "Preguntas asignadas:",
                asignadas
            );

            return mostrarError(
                `La evaluación debe tener 40 preguntas. ` +
                `Se encontraron ${asignadas?.length || 0}.`
            );
        }

        // -------------------------------------------------
        // OBTENER BANCO DE PREGUNTAS
        // -------------------------------------------------

        const questionIds = asignadas.map(
            row => row.question_id
        );

        const {
            data: banco,
            error: bankError
        } = await supabaseClient
            .from("exam_questions_for_students")
            .select("*")
            .in("id", questionIds);

        if (bankError) {
            console.error(
                "Error obteniendo banco:",
                bankError
            );

            return mostrarError(
                "No fue posible cargar el banco de preguntas."
            );
        }

        if (
            !banco ||
            banco.length !== 40
        ) {
            console.error(
                "Preguntas recibidas:",
                banco
            );

            return mostrarError(
                "No fue posible cargar las 40 preguntas de la evaluación."
            );
        }

        // -------------------------------------------------
        // ORDENAR SEGÚN QUESTION_ORDER
        // -------------------------------------------------

        const porId = new Map(
            banco.map(question => [
                question.id,
                question
            ])
        );

        preguntas = asignadas.map(row => {
            const pregunta = porId.get(
                row.question_id
            );

            if (!pregunta) {
                return null;
            }

            return {
                ...pregunta,
                question_order:
                    row.question_order
            };
        });

        // -------------------------------------------------
        // VALIDAR INTEGRIDAD
        // -------------------------------------------------

        if (
            preguntas.some(
                pregunta => !pregunta
            )
        ) {
            return mostrarError(
                "Existe una inconsistencia entre las preguntas asignadas y el banco."
            );
        }

        // -------------------------------------------------
        // ESTADO INICIAL
        // -------------------------------------------------

        respuestas = asignadas.map(
            row => row.selected_option || null
        );

        preguntaActual = 0;

        finalizado = false;

        const totalQuestions =
            document.getElementById(
                "totalQuestions"
            );

        if (totalQuestions) {
            totalQuestions.textContent =
                preguntas.length;
        }

        // -------------------------------------------------
        // MOSTRAR PRIMERA PREGUNTA
        // -------------------------------------------------

        dibujar(0);

        // -------------------------------------------------
        // INICIAR TEMPORIZADOR
        // -------------------------------------------------

        const {
            data: attempt,
            error: attemptError
        } = await supabaseClient
            .from("exam_attempts")
            .select("started_at")
            .eq("id", attemptId)
            .single();

        if (attemptError || !attempt) {
            return mostrarError(
                "No fue posible recuperar el tiempo de tu evaluación."
            );
        }

        iniciarReloj(attempt.started_at);

        console.log(
            "Examen cargado correctamente."
        );

        console.log(
            "Categoría:",
            categoria
        );

        console.log(
            "Total preguntas:",
            preguntas.length
        );
    } catch (error) {
        console.error(
            "Error inesperado:",
            error
        );

        mostrarError(
            "Ocurrió un error inesperado al iniciar la evaluación."
        );
    }
}

// =========================================================
// IDENTIDAD
// =========================================================

function mostrarIdentidad(
    nombre,
    categoria
) {
    const examUserName =
        document.getElementById(
            "examUserName"
        );

    const examWelcomeName =
        document.getElementById(
            "examWelcomeName"
        );

    const examUserInitial =
        document.getElementById(
            "examUserInitial"
        );

    const examCategory =
        document.getElementById(
            "examCategory"
        );

    if (examUserName) {
        examUserName.textContent =
            nombre;
    }

    if (examWelcomeName) {
        examWelcomeName.textContent =
            nombre;
    }

    if (examUserInitial) {
        examUserInitial.textContent =
            nombre
                .charAt(0)
                .toUpperCase();
    }

    if (examCategory) {
        examCategory.textContent =
            `Categoría ${categoria}`;
    }
}

// =========================================================
// EVENTOS
// =========================================================

function configurarEventos() {
    const previousButton =
        document.getElementById(
            "previousQuestionButton"
        );

    const nextButton =
        document.getElementById(
            "nextQuestionButton"
        );

    const finishButton =
        document.getElementById(
            "finishExamButton"
        );

    const reviewFinishButton =
        document.getElementById(
            "reviewFinishButton"
        );

    const confirmFinishButton =
        document.getElementById(
            "confirmFinishButton"
        );

    const cancelFinishButton =
        document.getElementById(
            "cancelFinishButton"
        );

    const closeFinishModal =
        document.getElementById(
            "closeFinishModal"
        );

    const logoutButton =
        document.getElementById(
            "logoutButton"
        );

    // -------------------------------------------------
    // ANTERIOR
    // -------------------------------------------------

    if (previousButton) {
        previousButton.onclick = () => {
            if (preguntaActual > 0) {
                dibujar(
                    preguntaActual - 1
                );
            }
        };
    }

    // -------------------------------------------------
    // SIGUIENTE
    // -------------------------------------------------

    if (nextButton) {
        nextButton.onclick = () => {
            if (
                preguntaActual ===
                preguntas.length - 1
            ) {
                mostrarFinalizacion();
                return;
            }

            if (
                !respuestas[preguntaActual]
            ) {
                return;
            }

            dibujar(
                preguntaActual + 1
            );
        };
    }

    // -------------------------------------------------
    // FINALIZAR
    // -------------------------------------------------

    if (finishButton) {
        finishButton.onclick = () => {
            abrirModal();
        };
    }

    if (reviewFinishButton) {
        reviewFinishButton.onclick = () => {
            if (respuestas.every(Boolean)) {
                abrirModal();
            }
        };
    }

    // -------------------------------------------------
    // CONFIRMAR FINALIZACIÓN
    // -------------------------------------------------

    if (confirmFinishButton) {
        confirmFinishButton.onclick = () => {
            finalizar(false);
        };
    }

    // -------------------------------------------------
    // CANCELAR
    // -------------------------------------------------

    if (cancelFinishButton) {
        cancelFinishButton.onclick =
            cerrarModal;
    }

    if (closeFinishModal) {
        closeFinishModal.onclick =
            cerrarModal;
    }

    // -------------------------------------------------
    // CERRAR MODAL AL HACER CLICK AFUERA
    // -------------------------------------------------

    const finishModal =
        document.getElementById(
            "finishModal"
        );

    if (finishModal) {
        finishModal.addEventListener(
            "click",
            event => {
                if (
                    event.target ===
                    finishModal
                ) {
                    cerrarModal();
                }
            }
        );
    }

    // -------------------------------------------------
    // LOGOUT
    // -------------------------------------------------

    if (logoutButton) {
        logoutButton.onclick =
            async () => {

                logoutButton.disabled =
                    true;

                logoutButton.textContent =
                    "Saliendo...";

                const {
                    error
                } = await supabaseClient
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

                    return;
                }

                window.location.replace(
                    "login.html"
                );
            };
    }
}

// =========================================================
// DIBUJAR PREGUNTA
// =========================================================

function dibujar(indice) {
    if (
        indice < 0 ||
        indice >= preguntas.length ||
        finalizado
    ) {
        return;
    }

    preguntaActual = indice;

    const q =
        preguntas[indice];

    if (!q) {
        return;
    }

    // -------------------------------------------------
    // INFORMACIÓN
    // -------------------------------------------------

    const currentQuestion =
        document.getElementById(
            "currentQuestion"
        );

    const questionNumber =
        document.getElementById(
            "questionNumber"
        );

    const questionText =
        document.getElementById(
            "questionText"
        );

    const questionCategory =
        document.getElementById(
            "questionCategory"
        );

    if (currentQuestion) {
        currentQuestion.textContent =
            indice + 1;
    }

    if (questionNumber) {
        questionNumber.textContent =
            `Pregunta ${String(
                indice + 1
            ).padStart(2, "0")}`;
    }

    if (questionText) {
        questionText.textContent =
            q.question_text || "";
    }

    if (questionCategory) {
        questionCategory.textContent =
            nombreModulo(q.module);
    }

    // -------------------------------------------------
    // IMAGEN
    // -------------------------------------------------

    mostrarImagen(q);

    // -------------------------------------------------
    // OPCIONES
    // -------------------------------------------------

    mostrarOpciones(q);

    // -------------------------------------------------
    // NAVEGACIÓN
    // -------------------------------------------------

    actualizarNavegacion();

    // -------------------------------------------------
    // PROGRESO
    // -------------------------------------------------

    actualizarProgreso();

    // -------------------------------------------------
    // DOTS
    // -------------------------------------------------

    actualizarDots();

    // -------------------------------------------------
    // OCULTAR SECCIÓN DE FINALIZACIÓN
    // -------------------------------------------------

    if (preguntaActual !== preguntas.length - 1) {
        const submitSection =
            document.getElementById(
                "examSubmitSection"
            );

        if (submitSection) {
            submitSection.classList.add(
                "hidden"
            );
        }
    }
}

// =========================================================
// MOSTRAR OPCIONES
// =========================================================

function mostrarOpciones(q) {
    const container =
        document.getElementById(
            "questionOptions"
        );

    if (!container) {
        return;
    }

    const opciones = [
        ["A", q.option_a],
        ["B", q.option_b],
        ["C", q.option_c],
        ["D", q.option_d]
    ];

    container.innerHTML = "";

    opciones.forEach(
        ([letra, texto]) => {

            const button =
                document.createElement(
                    "button"
                );

            button.type = "button";

            button.className =
                "answer-option";

            button.dataset.option =
                letra;

            if (
                respuestas[
                    preguntaActual
                ] === letra
            ) {
                button.classList.add(
                    "selected"
                );
            }

            const letter =
                document.createElement(
                    "span"
                );

            letter.className =
                "answer-letter";

            letter.textContent =
                letra;

            const answerText =
                document.createElement(
                    "span"
                );

            answerText.className =
                "answer-text";

            answerText.textContent =
                texto || "";

            button.appendChild(
                letter
            );

            button.appendChild(
                answerText
            );

            button.onclick = () => {
                responder(letra);
            };

            container.appendChild(
                button
            );
        }
    );
}

// =========================================================
// MOSTRAR IMAGEN
// =========================================================

function mostrarImagen(q) {
    const wrapper =
        document.getElementById(
            "questionImageWrapper"
        );

    const image =
        document.getElementById(
            "questionImage"
        );

    if (
        !wrapper ||
        !image
    ) {
        return;
    }

    if (
        q.image_url &&
        String(
            q.image_url
        ).trim() !== ""
    ) {
        image.src = resolverRutaImagen(q.image_url);

        image.alt =
            "Imagen relacionada con la pregunta";

        wrapper.classList.remove(
            "hidden"
        );
    } else {
        image.removeAttribute(
            "src"
        );

        image.alt = "";

        wrapper.classList.add(
            "hidden"
        );
    }
}

function resolverRutaImagen(imageUrl) {
    const value = String(imageUrl || '').trim();
    if (/^https?:\/\//i.test(value) || value.startsWith('data:')) return value;
    // Admite registros antiguos (/images/...) y los normaliza a la ubicación
    // pública actual: frontend/assets/images.
    return value
        .replace(/^\/?(?:assets\/)?images\//i, 'assets/images/')
        .replace(/^\//, '');
}

// =========================================================
// RESPONDER
// =========================================================

async function responder(opcion) {
    if (
        finalizado ||
        !attemptId ||
        guardandoRespuesta
    ) {
        return;
    }

    const indice =
        preguntaActual;

    const pregunta =
        preguntas[indice];

    if (!pregunta) {
        return;
    }

    // -------------------------------------------------
    // ACTUALIZAR INTERFAZ
    // -------------------------------------------------

    const respuestaAnterior = respuestas[indice];

    guardandoRespuesta = true;

    respuestas[indice] = opcion;

    dibujar(indice);

    const answerMessage =
        document.getElementById(
            "answerMessage"
        );

    if (answerMessage) {
        answerMessage.textContent =
            "Guardando respuesta...";
    }

    // -------------------------------------------------
    // GUARDAR EN SUPABASE
    // -------------------------------------------------

    const {
        error
    } = await supabaseClient.rpc(
        "save_exam_answer",
        {
            p_attempt:
                attemptId,

            p_order:
                pregunta.question_order,

            p_option:
                opcion
        }
    );

    if (error) {
        guardandoRespuesta = false;

        respuestas[indice] = respuestaAnterior;

        if (preguntaActual === indice) {
            dibujar(indice);
        }

        console.error(
            "Error guardando respuesta:",
            error
        );

        mostrarError(
            "No fue posible guardar la respuesta. " +
            error.message
        );

        return;
    }

    if (answerMessage) {
        answerMessage.textContent =
            "Respuesta guardada.";
    }

    guardandoRespuesta = false;

    window.setTimeout(
        () => {
            if (finalizado || indice !== preguntaActual) {
                return;
            }

            if (indice < preguntas.length - 1) {
                dibujar(indice + 1);
            } else if (respuestas.every(Boolean)) {
                mostrarFinalizacion();
            }
        },
        280
    );

    console.log(
        `Respuesta guardada: pregunta ${pregunta.question_order} = ${opcion}`
    );
}

// =========================================================
// NAVEGACIÓN
// =========================================================

function actualizarNavegacion() {
    const previousButton =
        document.getElementById(
            "previousQuestionButton"
        );

    const nextButton =
        document.getElementById(
            "nextQuestionButton"
        );

    if (previousButton) {
        previousButton.disabled =
            preguntaActual === 0;
    }

    if (nextButton) {
        const respondida =
            Boolean(
                respuestas[
                    preguntaActual
                ]
            );

        nextButton.disabled =
            !respondida;
    }

    const reviewFinishButton =
        document.getElementById(
            "reviewFinishButton"
        );

    if (reviewFinishButton) {
        reviewFinishButton.disabled =
            !respuestas.every(Boolean);
    }
}

// =========================================================
// PROGRESO
// =========================================================

function actualizarProgreso() {
    const total =
        preguntas.length;

    if (!total) {
        return;
    }

    const completadas =
        respuestas.filter(
            Boolean
        ).length;

    const porcentaje =
        Math.round(
            (completadas / total) * 100
        );

    const progressPercent =
        document.getElementById(
            "progressPercent"
        );

    const progressBar =
        document.getElementById(
            "examProgressBar"
        );

    if (progressPercent) {
        progressPercent.textContent =
            `${porcentaje}%`;
    }

    if (progressBar) {
        progressBar.style.width =
            `${porcentaje}%`;
    }
}

// =========================================================
// DOTS
// =========================================================

function actualizarDots() {
    const box =
        document.getElementById(
            "questionDots"
        );

    if (!box) {
        return;
    }

    box.innerHTML = "";

    preguntas.forEach(
        (_, indice) => {

            const button =
                document.createElement(
                    "button"
                );

            button.type = "button";

            button.className =
                "question-dot";

            if (
                indice ===
                preguntaActual
            ) {
                button.classList.add(
                    "active"
                );
            }

            if (
                respuestas[indice]
            ) {
                button.classList.add(
                    "answered"
                );
            }

            button.textContent =
                indice + 1;

            button.title =
                `Ir a la pregunta ${indice + 1}`;

            button.onclick = () => {
                dibujar(indice);
            };

            box.appendChild(
                button
            );
        }
    );
}

// =========================================================
// MOSTRAR FINALIZACIÓN
// =========================================================

function mostrarFinalizacion() {
    const submitSection =
        document.getElementById(
            "examSubmitSection"
        );

    if (!submitSection) {
        abrirModal();
        return;
    }

    submitSection.classList.remove(
        "hidden"
    );

    submitSection.scrollIntoView({
        behavior: "smooth",
        block: "center"
    });
}

// =========================================================
// MODAL
// =========================================================

function abrirModal() {
    const modal =
        document.getElementById(
            "finishModal"
        );

    if (modal) {
        modal.classList.remove(
            "hidden"
        );
    }
}

function cerrarModal() {
    const modal =
        document.getElementById(
            "finishModal"
        );

    if (modal) {
        modal.classList.add(
            "hidden"
        );
    }
}

// =========================================================
// FINALIZAR
// =========================================================

async function finalizar(
    expirado = false
) {
    if (
        finalizado ||
        !attemptId
    ) {
        return;
    }

    const confirmButton =
        document.getElementById(
            "confirmFinishButton"
        );

    if (confirmButton) {
        confirmButton.disabled =
            true;

        confirmButton.textContent =
            expirado
                ? "Finalizando..."
                : "Guardando...";
    }

    const {
        error
    } = await supabaseClient.rpc(
        "finish_exam_attempt",
        {
            p_attempt:
                attemptId,

            p_expired:
                expirado
        }
    );

    if (error) {
        console.error(
            "Error finalizando intento:",
            error
        );

        if (confirmButton) {
            confirmButton.disabled =
                false;

            confirmButton.textContent =
                "Finalizar";
        }

        mostrarError(
            "No fue posible finalizar la evaluación. " +
            error.message
        );

        return;
    }

    finalizado = true;

    if (timerId) {
        clearInterval(
            timerId
        );

        timerId = null;
    }

    cerrarModal();

    window.location.replace(
        `resultado.html?id=${encodeURIComponent(
            attemptId
        )}`
    );
}

// =========================================================
// RELOJ
// =========================================================

function iniciarReloj(startedAt) {
    let restante = Math.max(
        0,
        40 * 60 - Math.floor(
            (Date.now() - new Date(startedAt).getTime()) / 1000
        )
    );

    const el =
        document.getElementById(
            "examTimer"
        );

    if (!el) {
        console.warn(
            "No existe #examTimer en examen.html"
        );

        return;
    }

    const tick = () => {
        const minutos =
            String(
                Math.floor(
                    restante / 60
                )
            ).padStart(
                2,
                "0"
            );

        const segundos =
            String(
                restante % 60
            ).padStart(
                2,
                "0"
            );

        el.textContent =
            `${minutos}:${segundos}`;

        if (
            restante <= 0
        ) {
            clearInterval(
                timerId
            );

            timerId = null;

            finalizar(true);

            return;
        }

        restante--;
    };

    tick();

    timerId =
        setInterval(
            tick,
            1000
        );
}

// =========================================================
// NOMBRE DEL MÓDULO
// =========================================================

function nombreModulo(
    modulo
) {
    const nombres = {
        vehicle:
            "Vehículo y generalidades",

        signage_infrastructure:
            "Señalización e infraestructura",

        traffic_rules:
            "Normativa de tránsito",

        safe_mobility:
            "Movilidad segura y sostenible",

        attitudes:
            "Actitudes y comportamiento vial"
    };

    return (
        nombres[modulo] ||
        "Evaluación teórica"
    );
}

// =========================================================
// ESTADO DE CARGA
// =========================================================

function mostrarCargando(
    mensaje
) {
    const questionText =
        document.getElementById(
            "questionText"
        );

    const questionOptions =
        document.getElementById(
            "questionOptions"
        );

    if (questionText) {
        questionText.textContent =
            mensaje;
    }

    if (questionOptions) {
        questionOptions.innerHTML =
            "";
    }
}

// =========================================================
// MOSTRAR ERROR
// =========================================================

function mostrarError(
    mensaje
) {
    console.error(
        mensaje
    );

    const questionText =
        document.getElementById(
            "questionText"
        );

    const questionOptions =
        document.getElementById(
            "questionOptions"
        );

    const nextButton =
        document.getElementById(
            "nextQuestionButton"
        );

    const previousButton =
        document.getElementById(
            "previousQuestionButton"
        );

    if (questionText) {
        questionText.textContent =
            mensaje;
    }

    if (questionOptions) {
        questionOptions.innerHTML =
            "";
    }

    if (nextButton) {
        nextButton.disabled =
            true;
    }

    if (previousButton) {
        previousButton.disabled =
            true;
    }
}
