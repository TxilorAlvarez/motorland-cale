const DETAIL_MODULES = { attitudes: "Actitudes y comportamiento vial", safe_mobility: "Movilidad segura y sostenible", traffic_rules: "Normativa de tránsito", signage_infrastructure: "Señalización e infraestructura", vehicle: "El vehículo" };

document.addEventListener("DOMContentLoaded", async () => {
    try {
        await esperarAdmin(); const id = new URLSearchParams(location.search).get("id");
        if (!id) throw new Error("No se especificó el intento.");
        const { data, error } = await supabaseClient.rpc("admin_attempt_detail", { p_attempt: id });
        if (error || !data?.attempt) throw error || new Error("Intento no encontrado.");
        renderDetail(data);
    } catch (error) { console.error("Error cargando aprendiz:", error); const el = document.getElementById("adminError"); if (el) { el.textContent = "No fue posible cargar el detalle del aprendiz."; el.classList.remove("hidden"); } }
});

function renderDetail(data) {
    const a = data.attempt; const name = `${a.nombres || ""} ${a.apellidos || ""}`.trim() || "Aprendiz"; const total = Number(a.total_questions || 40); const correct = Number(a.total_correct || 0); const score = Number(a.total_score || 0);
    set("studentInitial", initials(name)); set("studentName", name); set("studentDetails", a.correo || "--"); set("studentDocument", a.documento || "--"); set("studentEnrollment", a.matricula || "--"); set("studentCategory", a.category || "--"); set("studentAttempts", "1");
    set("studentScore", `${score.toFixed(1)}%`); set("studentCorrect", correct); set("studentIncorrect", total - correct); set("studentTime", formatTime(a.duration_seconds)); set("studentLastDate", formatDate(a.finished_at)); set("studentStatus", a.passed ? "APROBADO" : "REPROBADO");
    const ring = document.getElementById("studentScoreRing"); if (ring) ring.style.setProperty("--score", `${score}%`);
    renderModules(data.modules || []); renderWrong(data.incorrect_answers || []);
}

function renderModules(modules) { const map = new Map(modules.map(x => [x.module, x])); Object.entries(DETAIL_MODULES).forEach(([key]) => { const score = Number(map.get(key)?.score || 0); const name = key === "safe_mobility" ? "Mobility" : key === "traffic_rules" ? "Traffic" : key === "signage_infrastructure" ? "Signage" : key === "attitudes" ? "Attitude" : "Vehicle"; set(`student${name}`, `${score.toFixed(1)}%`); const bar = document.getElementById(`student${name}Bar`); if (bar) bar.style.width = `${score}%`; }); }
function renderWrong(items) { const list = document.getElementById("wrongAnswersList"); const count = document.getElementById("wrongAnswerCount"); if (count) count.textContent = items.length; if (!list) return; list.replaceChildren(); if (!items.length) return list.append(el("p", "", "No se registraron respuestas incorrectas.")); items.forEach(item => { const card = el("article", "wrong-answer-item"); const source = [item.legal_source, item.legal_article, item.legal_reference].filter(Boolean).join(" · "); card.append(el("strong", "", `Pregunta ${String(item.question_order).padStart(2, "0")} · ${DETAIL_MODULES[item.module] || item.module}`), el("p", "", item.question_text), el("p", "", `Respondió: ${option(item, item.selected_option)}`), el("p", "", `Correcta: ${option(item, item.correct_option)}`), el("p", "", item.explanation || "Repasar este tema."), el("small", "", source)); list.append(card); }); }
function option(item, letter) { return letter ? `${letter}. ${item[`option_${letter.toLowerCase()}`] || ""}` : "Sin responder"; }
async function esperarAdmin() { for (let i = 0; i < 50 && !window.adminSession; i++) await new Promise(resolve => setTimeout(resolve, 100)); if (!window.adminSession) throw new Error("Acceso administrativo no validado."); }
function set(id, value) { const node = document.getElementById(id); if (node) node.textContent = value; }
function el(tag, className, text) { const node = document.createElement(tag); node.className = className; node.textContent = text || ""; return node; }
function initials(value) { return value.split(/\s+/).filter(Boolean).map(x => x[0]).slice(0, 2).join("").toUpperCase(); }
function formatTime(value) { return value ? `${Math.floor(value / 60)} min ${value % 60} s` : "--"; }
function formatDate(value) { return value ? new Date(value).toLocaleDateString("es-CO") : "--"; }
