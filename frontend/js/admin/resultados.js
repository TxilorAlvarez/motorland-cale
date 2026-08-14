let page = 1;
const PAGE_SIZE = 25;

document.addEventListener("DOMContentLoaded", async () => {
    try {
        await esperarAdmin();
        ["searchResults", "resultCategory", "resultStatus"].forEach(id => document.getElementById(id)?.addEventListener(id === "searchResults" ? "input" : "change", () => { page = 1; cargarResultados(); }));
        document.getElementById("refreshResults")?.addEventListener("click", cargarResultados);
        document.getElementById("previousPage")?.addEventListener("click", () => { page--; cargarResultados(); });
        document.getElementById("nextPage")?.addEventListener("click", () => { page++; cargarResultados(); });
        await cargarResultados();
    } catch (error) { console.error("Error cargando resultados:", error); mostrarError("No fue posible cargar los resultados."); }
});

async function cargarResultados() {
    mostrarCarga();
    const category = document.getElementById("resultCategory")?.value;
    const status = document.getElementById("resultStatus")?.value;
    const { data, error } = await supabaseClient.rpc("admin_results_page", {
        p_page: page, p_page_size: PAGE_SIZE,
        p_category: category === "all" ? null : category || null,
        p_status: status === "all" || status === "in_progress" ? null : status || null,
        p_search: document.getElementById("searchResults")?.value.trim() || null
    });
    if (error) throw error;
    setText("resultsTotal", data.total || 0); setText("resultsApproved", data.approved || 0); setText("resultsFailed", data.failed || 0); setText("resultsAverage", `${Number(data.average_score || 0).toFixed(1)}%`); setText("tableCount", `${data.total || 0} resultados`);
    document.getElementById("paginationInfo").textContent = `${page} / ${Math.max(1, Math.ceil((data.total || 0) / PAGE_SIZE))}`;
    document.getElementById("previousPage").disabled = page <= 1; document.getElementById("nextPage").disabled = page >= Math.ceil((data.total || 0) / PAGE_SIZE);
    const body = document.getElementById("resultsTableBody"); body.replaceChildren();
    if (!data.items?.length) return body.append(emptyRow("No hay simulacros registrados."));
    data.items.forEach(item => body.append(row(item)));
}

function row(item) { const tr = document.createElement("tr"); const name = `${item.nombres || ""} ${item.apellidos || ""}`.trim() || "Aprendiz"; const values = [name, item.documento || item.matricula || "--", item.category, formatDate(item.finished_at), `${item.total_correct}/${item.total_questions}`, `${Math.max(0, item.total_questions - item.total_correct)}`, `${Number(item.total_score).toFixed(1)}%`, formatTime(item.duration_seconds), item.passed ? "Aprobado" : "Reprobado"]; values.forEach(value => { const td = document.createElement("td"); td.textContent = value; tr.append(td); }); const action = document.createElement("a"); action.className = "view-button"; action.href = `aprendiz.html?id=${encodeURIComponent(item.id)}`; action.textContent = "Ver resultado"; const td = document.createElement("td"); td.append(action); tr.append(td); return tr; }
function emptyRow(text) { const tr = document.createElement("tr"), td = document.createElement("td"); td.colSpan = 10; td.className = "table-loading"; td.textContent = text; tr.append(td); return tr; }
function mostrarCarga() { const body = document.getElementById("resultsTableBody"); if (body) { body.replaceChildren(emptyRow("Cargando resultados...")); } }
async function esperarAdmin() { for (let i = 0; i < 50 && !window.adminSession; i++) await new Promise(resolve => setTimeout(resolve, 100)); if (!window.adminSession) throw new Error("Acceso administrativo no validado."); }
function setText(id, value) { const el = document.getElementById(id); if (el) el.textContent = value; }
function formatTime(seconds) { return seconds ? `${Math.floor(seconds / 60)} min` : "--"; }
function formatDate(date) { return date ? new Date(date).toLocaleDateString("es-CO") : "--"; }
function mostrarError(message) { const body = document.getElementById("resultsTableBody"); if (body) body.replaceChildren(emptyRow(message)); }
