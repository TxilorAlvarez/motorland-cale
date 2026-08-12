let preguntas = [], respuestas = [], preguntaActual = 0, attemptId, finalizado = false, timerId;

document.addEventListener("DOMContentLoaded", iniciar);

async function iniciar() {
    const { data: { session } } = await supabaseClient.auth.getSession();
    if (!session) return location.replace("login.html");
    const { data: profile, error } = await supabaseClient.from("profiles").select("nombres,categoria").eq("id", session.user.id).single();
    const categoria = String(profile?.categoria || "").toUpperCase();
    if (error || !["A2", "B1", "C1"].includes(categoria)) return mostrarError("No fue posible validar tu categoría.");
    const nombre = (profile.nombres || "Estudiante").trim().split(/\s+/)[0];
    ["examUserName", "examWelcomeName"].forEach(id => document.getElementById(id).textContent = nombre);
    document.getElementById("examUserInitial").textContent = nombre[0].toUpperCase();
    document.getElementById("examCategory").textContent = `Categoría ${categoria}`;
    configurarEventos();
    const { data, error: startError } = await supabaseClient.rpc("start_exam_attempt");
    if (startError) return mostrarError(startError.message);
    attemptId = data;
    const { data: asignadas, error: questionsError } = await supabaseClient.from("exam_attempt_questions")
        .select("question_order,question_id").eq("attempt_id", attemptId).order("question_order");
    if (questionsError || asignadas.length !== 40) return mostrarError("No fue posible cargar las preguntas asignadas.");
    const { data: banco, error: bankError } = await supabaseClient.from("exam_questions_for_students").select("*").in("id", asignadas.map(row => row.question_id));
    if (bankError || banco.length !== 40) return mostrarError("No fue posible cargar las preguntas asignadas.");
    const porId = new Map(banco.map(question => [question.id, question]));
    preguntas = asignadas.map(row => ({ ...porId.get(row.question_id), question_order: row.question_order }));
    respuestas = Array(40).fill(null); document.getElementById("totalQuestions").textContent = "40";
    dibujar(0); iniciarReloj();
}

function configurarEventos() {
    document.getElementById("previousQuestionButton").onclick = () => dibujar(preguntaActual - 1);
    document.getElementById("nextQuestionButton").onclick = () => preguntaActual === 39 ? mostrarFinalizacion() : dibujar(preguntaActual + 1);
    document.getElementById("finishExamButton").onclick = () => document.getElementById("finishModal").classList.remove("hidden");
    document.getElementById("confirmFinishButton").onclick = () => finalizar(false);
    ["cancelFinishButton", "closeFinishModal"].forEach(id => document.getElementById(id).onclick = () => document.getElementById("finishModal").classList.add("hidden"));
    document.getElementById("logoutButton").onclick = async () => { await supabaseClient.auth.signOut(); location.replace("login.html"); };
}

function dibujar(indice) {
    if (indice < 0 || indice >= preguntas.length || finalizado) return;
    preguntaActual = indice; const q = preguntas[indice];
    document.getElementById("currentQuestion").textContent = indice + 1;
    document.getElementById("questionNumber").textContent = `Pregunta ${String(indice + 1).padStart(2, "0")}`;
    document.getElementById("questionText").textContent = q.question_text;
    document.getElementById("questionCategory").textContent = nombreModulo(q.module);
    const opciones = [["A", q.option_a], ["B", q.option_b], ["C", q.option_c], ["D", q.option_d]];
    document.getElementById("questionOptions").innerHTML = opciones.map(([l, t]) => `<button type="button" class="answer-option ${respuestas[indice] === l ? "selected" : ""}" data-option="${l}"><span class="answer-letter">${l}</span><span class="answer-text"></span></button>`).join("");
    document.querySelectorAll(".answer-option").forEach((button, i) => { button.querySelector(".answer-text").textContent = opciones[i][1]; button.onclick = () => responder(button.dataset.option); });
    document.getElementById("previousQuestionButton").disabled = indice === 0;
    document.getElementById("nextQuestionButton").disabled = !respuestas[indice];
    const completadas = respuestas.filter(Boolean).length; document.getElementById("progressPercent").textContent = `${Math.round(completadas / 40 * 100)}%`; document.getElementById("examProgressBar").style.width = `${completadas / 40 * 100}%`;
    actualizarDots();
}

async function responder(opcion) {
    respuestas[preguntaActual] = opcion; dibujar(preguntaActual);
    const { error } = await supabaseClient.rpc("save_exam_answer", { p_attempt: attemptId, p_order: preguntas[preguntaActual].question_order, p_option: opcion });
    if (error) mostrarError("No fue posible guardar la respuesta. " + error.message);
}
function actualizarDots() { const box = document.getElementById("questionDots"); if (!box) return; box.innerHTML = preguntas.map((_, i) => `<button type="button" class="question-dot ${i === preguntaActual ? "active" : ""} ${respuestas[i] ? "answered" : ""}">${i + 1}</button>`).join(""); [...box.children].forEach((b, i) => b.onclick = () => dibujar(i)); }
function mostrarFinalizacion() { document.getElementById("examSubmitSection").classList.remove("hidden"); }
async function finalizar(expirado) { if (finalizado) return; finalizado = true; clearInterval(timerId); const { error } = await supabaseClient.rpc("finish_exam_attempt", { p_attempt: attemptId, p_expired: expirado }); if (error) return mostrarError(error.message); location.replace(`resultado.html?id=${attemptId}`); }
function iniciarReloj() { let restante = 70 * 60; const el = document.getElementById("examTimer"); const tick = () => { const m = String(Math.floor(restante / 60)).padStart(2, "0"), s = String(restante % 60).padStart(2, "0"); el.textContent = `${m}:${s}`; if (restante-- <= 0) finalizar(true); }; tick(); timerId = setInterval(tick, 1000); }
function nombreModulo(m) { return ({ vehicle: "Vehículo y generalidades", signage_infrastructure: "Señalización e infraestructura", traffic_rules: "Normativa de tránsito", safe_mobility: "Movilidad segura", attitudes: "Actitudes y comportamiento vial" })[m]; }
function mostrarError(mensaje) { console.error(mensaje); document.getElementById("questionText").textContent = mensaje; document.getElementById("questionOptions").innerHTML = ""; }
