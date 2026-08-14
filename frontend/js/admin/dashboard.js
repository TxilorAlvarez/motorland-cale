document.addEventListener("DOMContentLoaded", iniciarAdminDashboard);

const MODULES = { attitudes: "Actitudes y comportamiento vial", safe_mobility: "Movilidad segura y sostenible", traffic_rules: "Normativa de tránsito", signage_infrastructure: "Señalización e infraestructura", vehicle: "El vehículo" };

async function iniciarAdminDashboard() {
    try {
        await esperarAdmin();
        await cargarDashboard();
        document.getElementById("categoryFilter")?.addEventListener("change", cargarDashboard);
    } catch (error) {
        console.error("Error cargando dashboard:", error);
        mostrarError("No fue posible cargar el dashboard. Intenta actualizar la página.");
    }
}

async function cargarDashboard() {
    const category = document.getElementById("categoryFilter")?.value || null;
    const { data, error } = await supabaseClient.rpc("admin_dashboard_data", { p_category: category === "all" ? null : category || null });
    if (error) throw error;
    const summary = data.summary || {};
    setText("totalStudents", summary.students || 0); setText("totalAttempts", summary.attempts || 0);
    setText("approvedCount", summary.approved || 0); setText("failedCount", summary.failed || 0); setText("pendingCount", summary.pending || 0);
    setText("averageScore", `${Number(summary.average_score || 0).toFixed(1)}%`);
    setText("approvalRate", `${summary.attempts ? ((summary.approved || 0) * 100 / summary.attempts).toFixed(1) : 0}%`);
    setText("scoreRingValue", `${Number(summary.average_score || 0).toFixed(0)}%`);
    document.getElementById("scoreRing")?.style.setProperty("--score", `${summary.average_score || 0}%`);
    renderModules(data.modules || []); renderRecent(data.recent || []); renderAlerts(data.modules || []);
}

function renderModules(modules) {
    const map = new Map(modules.map(item => [item.module, item]));
    Object.entries(MODULES).forEach(([key]) => {
        const score = Number(map.get(key)?.score || 0); const suffix = key === "safe_mobility" ? "mobility" : key === "traffic_rules" ? "traffic" : key === "signage_infrastructure" ? "signage" : key === "attitudes" ? "attitude" : "vehicle";
        setText(`${suffix}Score`, `${score.toFixed(1)}%`); const bar = document.getElementById(`${suffix}Bar`); if (bar) bar.style.width = `${score}%`;
    });
}

function renderRecent(items) {
    const container = document.getElementById("recentResults"); if (!container) return;
    container.replaceChildren();
    if (!items.length) return container.append(create("p", "table-loading", "No hay simulacros finalizados."));
    items.forEach(item => { const row = create("a", "recent-result"); row.href = `aprendiz.html?id=${encodeURIComponent(item.id)}`; row.textContent = `${item.student_name} · ${item.category} · ${Number(item.total_score).toFixed(1)}%`; container.append(row); });
}

function renderAlerts(modules) {
    const container = document.getElementById("alertsList"); if (!container) return;
    const alerts = modules.filter(item => Number(item.score) < 80); setText("alertCount", alerts.length);
    container.replaceChildren();
    if (!alerts.length) return container.append(create("p", "", "No hay módulos por debajo del 80%."));
    alerts.forEach(item => container.append(create("p", "", `${MODULES[item.module] || item.module}: ${Number(item.score).toFixed(1)}%. Requiere refuerzo.`)));
}

async function esperarAdmin() { for (let i = 0; i < 50 && !window.adminSession; i++) await new Promise(resolve => setTimeout(resolve, 100)); if (!window.adminSession) throw new Error("Acceso administrativo no validado."); }
function setText(id, value) { const element = document.getElementById(id); if (element) element.textContent = value; }
function create(tag, className, text) { const el = document.createElement(tag); el.className = className; el.textContent = text; return el; }
function mostrarError(message) { const el = document.getElementById("adminError"); if (el) { el.textContent = message; el.classList.remove("hidden"); } }
