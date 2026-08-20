document.addEventListener("DOMContentLoaded", async () => {
    const { data: { session } } = await supabaseClient.auth.getSession();
    if (!session) return location.replace("login.html");

    const id = new URLSearchParams(location.search).get("id");
    if (!id) return location.replace("dashboard.html");

    const [{ data: intento, error }, { data: profile }, { data: modulos, error: modulesError }, { data: respuestas, error: reviewError }] = await Promise.all([
        supabaseClient.from("exam_attempts").select("category,started_at,finished_at,duration_seconds,total_questions,total_correct,total_score,passed,status").eq("id", id).single(),
        supabaseClient.from("profiles").select("nombres").eq("id", session.user.id).single(),
        supabaseClient.from("exam_attempt_module_results").select("module,total_questions,correct_answers,score").eq("attempt_id", id),
        supabaseClient.from("exam_attempt_review").select("question_order,module,selected_option,correct_option,is_correct,option_a,option_b,option_c,option_d,explanation,legal_source,legal_article,legal_reference,fundament_type,technical_source,source_note").eq("attempt_id", id).eq("is_correct", false).order("question_order")
    ]);

    if (error || !intento) return location.replace("dashboard.html");

    renderResult(intento, profile);
    renderModules(modulos || [], modulesError);
    renderReview(respuestas || [], reviewError);
});

function renderResult(attempt, profile) {
    const nombre = (profile?.nombres || "Estudiante").split(/\s+/)[0];
    const vencido = attempt.status === "expired";
    const seconds = attempt.duration_seconds || 0;

    document.getElementById("resultTitle").textContent = `${nombre}, este es tu resultado.`;
    document.getElementById("resultSubtitle").textContent = vencido ? "El tiempo de la evaluación terminó." : "Tu evaluación fue registrada correctamente.";
    document.getElementById("resultScore").textContent = `${Number(attempt.total_score).toLocaleString("es-CO", { maximumFractionDigits: 1 })}%`;
    document.getElementById("resultPassed").textContent = attempt.passed ? "APROBADO" : "NO APROBADO";
    document.getElementById("resultState").textContent = vencido ? "TIEMPO FINALIZADO" : "EVALUACIÓN FINALIZADA";
    document.getElementById("resultCategory").textContent = attempt.category;
    document.getElementById("resultCorrect").textContent = `${attempt.total_correct} / ${attempt.total_questions}`;
    document.getElementById("resultDate").textContent = new Date(attempt.finished_at || attempt.started_at).toLocaleDateString("es-CO");
    document.getElementById("resultDuration").textContent = `${Math.floor(seconds / 60)} min ${seconds % 60} s`;
    document.getElementById("resultFeedback").textContent = attempt.passed ? "Alcanzaste el mínimo de 80% requerido en conocimientos y actitudes." : "El mínimo de aprobación es 80% tanto en conocimientos como en actitudes. Revisa los componentes por reforzar.";
}

function renderModules(results, error) {
    const container = document.getElementById("moduleScores");
    if (error) {
        console.error("Error cargando resultados por componente:", error);
        document.getElementById("resultFeedback").textContent = "No fue posible cargar el reporte por componente. Intenta nuevamente en unos segundos.";
        return;
    }

    const modules = [["attitudes", "Actitudes y comportamiento vial"], ["safe_mobility", "Movilidad segura y sostenible"], ["traffic_rules", "Normas de tránsito"], ["signage_infrastructure", "Señalización e infraestructura vial"], ["vehicle", "El vehículo"]];
    const byModule = new Map(results.map(result => [result.module, result]));

    modules.forEach(([module, label]) => {
        const result = byModule.get(module);
        const score = Math.max(0, Math.min(100, Number(result?.score || 0)));
        const level = score >= 80 ? "good" : score >= 60 ? "warning" : "needs-work";
        const item = document.createElement("div");
        item.className = "score-bar-item";
        item.append(
            createElement("div", "score-bar-heading", [createElement("span", "", label), createElement("strong", `score-${level}`, `${score.toFixed(0)}% · ${result?.correct_answers || 0}/${result?.total_questions || 0}`)]),
            createElement("div", "score-bar", [createElement("div", `score-${level}`, "", { style: `width: ${score}%`, "aria-label": `${label}: ${score.toFixed(0)}%` })])
        );
        container.append(item);
    });
}

function renderReview(answers, error) {
    const summary = document.getElementById("reviewSummary");
    const container = document.getElementById("incorrectAnswers");
    if (error) {
        console.error("Error cargando revisión de respuestas:", error);
        summary.textContent = "No fue posible cargar la revisión de respuestas. Intenta nuevamente en unos segundos.";
        return;
    }
    if (!answers.length) {
        summary.textContent = "¡Excelente! No tienes respuestas por reforzar en este intento.";
        return;
    }

    summary.textContent = `${answers.length} ${answers.length === 1 ? "respuesta para reforzar" : "respuestas para reforzar"}. Revisa por qué la opción correcta es la más segura.`;
    answers.forEach(answer => container.append(createReviewCard(answer)));
}

function createReviewCard(answer) {
    const moduleName = nombreModulo(answer.module);
    const source = sourceFor(answer);
    const card = createElement("article", "review-card");
    card.append(
        createElement("div", "review-card-header", [createElement("strong", "", `Pregunta ${String(answer.question_order).padStart(2, "0")}`), createElement("span", "review-incorrect", "✕ Incorrecta")]),
        createReviewField("Tu respuesta", optionLabel(answer, answer.selected_option)),
        createReviewField("Respuesta correcta", optionLabel(answer, answer.correct_option), "review-correct"),
        createReviewField("Tema", moduleName),
        createReviewField("Fuente", source),
        createReviewField("💡 Para reforzar", answer.explanation || `Repasa el tema “${moduleName}” antes de presentar nuevamente el simulacro.`, "review-tip")
    );
    return card;
}

function sourceFor(answer) {
    const legal = [answer.legal_source, answer.legal_article, answer.legal_reference].filter(Boolean);
    const technical = [answer.technical_source, answer.source_note].filter(Boolean);
    const sources = [...legal, ...technical];
    return sources.length ? sources.join(" · ") : "Fuente no registrada para esta pregunta.";
}

function createReviewField(label, value, className = "") {
    return createElement("div", `review-field ${className}`, [createElement("span", "review-label", label), createElement("p", "", value)]);
}

function optionLabel(answer, option) {
    if (!option) return "Sin responder";
    return `${option}. ${answer[`option_${option.toLowerCase()}`] || ""}`;
}

function nombreModulo(module) {
    return { attitudes: "Actitudes y comportamiento vial", safe_mobility: "Movilidad segura y sostenible", traffic_rules: "Normas de tránsito", signage_infrastructure: "Señalización e infraestructura vial", vehicle: "El vehículo" }[module] || "Evaluación teórica";
}

function createElement(tag, className, content = "", attributes = {}) {
    const element = document.createElement(tag);
    if (className) element.className = className;
    if (typeof content === "string") element.textContent = content;
    else element.append(...content);
    Object.entries(attributes).forEach(([name, value]) => element.setAttribute(name, value));
    return element;
}
