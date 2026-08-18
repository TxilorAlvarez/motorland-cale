document.addEventListener("DOMContentLoaded", iniciarAdminDashboard);

const MODULES = {
    attitudes: "Actitudes y comportamiento vial",
    safe_mobility: "Movilidad segura y sostenible",
    traffic_rules: "Normativa de tránsito",
    signage_infrastructure: "Señalización e infraestructura",
    vehicle: "El vehículo"
};

function clampScore(value) {
    const numeric = Number(value || 0);
    if (!Number.isFinite(numeric)) return 0;
    return Math.min(100, Math.max(0, numeric));
}

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
    const { data, error } = await supabaseClient.rpc("admin_dashboard_data", {
        p_category: category === "all" ? null : category || null
    });

    if (error) {
        console.error("RPC admin_dashboard_data falló:", error);
        throw error;
    }

    // Diagnostic logging to trace the shape
    console.log('[ADMIN DASHBOARD] RPC:', data);

    const summary = data?.summary || {};
    console.log('[ADMIN DASHBOARD] SUMMARY:', summary, 'average_score:', summary?.average_score);
    const modules = Array.isArray(data?.modules) ? data.modules : [];
    const recent = Array.isArray(data?.recent) ? data.recent : [];

    setText("totalStudents", summary.students ?? 0);
    setText("totalAttempts", summary.attempts ?? 0);
    setText("approvedCount", summary.approved ?? 0);
    setText("failedCount", summary.failed ?? 0);
    setText("pendingCount", summary.pending ?? 0);
    // Colorize counts
    const approvedEl = document.getElementById('approvedCount');
    const failedEl = document.getElementById('failedCount');
    const pendingEl = document.getElementById('pendingCount');
    if (approvedEl) approvedEl.style.color = '#10b981';
    if (failedEl) failedEl.style.color = '#ef4444';
    if (pendingEl) pendingEl.style.color = '#73736d';

    const avgScore = clampScore(summary.average_score);
    setText("averageScore", `${avgScore.toFixed(1)}%`);
    setText("scoreRingValue", `${avgScore.toFixed(0)}%`);

    // Set CSS vars on the .score-ring container (not the inner progress) so the gradient reads the correct var
    const ringContainer = document.querySelector('.score-ring');
    if (ringContainer) {
        ringContainer.style.setProperty('--score', `${avgScore}%`);
        // determine color variable
        const scoreColor = avgScore >= 80 ? '#10b981' : avgScore >= 20 ? '#f59e0b' : '#ef4444';
        ringContainer.style.setProperty('--score-color', scoreColor);
    } else {
        // fallback: no-op (scoreRing element removed in HTML, container .score-ring is primary target)
    }

    // Color center value based on thresholds: <20 red, 20-79 yellow, >=80 green
    const centerStrong = document.getElementById('scoreRingValue');
    if (centerStrong) {
        if (avgScore >= 80) centerStrong.style.color = '#10b981';
        else if (avgScore >= 20) centerStrong.style.color = '#f59e0b';
        else centerStrong.style.color = '#ef4444';
    }

    const totalAttempts = Number(summary.attempts || 0);
    const approvalRate = totalAttempts ? ((Number(summary.approved || 0) * 100) / totalAttempts) : 0;
    setText("approvalRate", `${approvalRate.toFixed(1)}%`);

    renderModules(modules);
    renderRecent(recent);
    renderActivity(recent);
    renderAlerts(modules);
}

function renderModules(modules) {
    const map = new Map((Array.isArray(modules) ? modules : []).map(item => [item.module, item]));
    Object.entries(MODULES).forEach(([key]) => {
        const score = clampScore(map.get(key)?.score);
        const id = key === "safe_mobility" ? "mobility" :
                   key === "traffic_rules" ? "traffic" :
                   key === "signage_infrastructure" ? "signage" :
                   key === "attitudes" ? "attitude" : "vehicle";
        setText(`${id}Score`, `${score.toFixed(1)}%`);
        const bar = document.getElementById(`${id}Bar`);
        if (bar) bar.style.width = `${score}%`;
    });
}

function renderRecent(items) {
    const container = document.getElementById("recentResults");
    if (!container) return;
    container.replaceChildren();

    if (!items || items.length === 0) {
        container.innerHTML = '<div class="empty-state"><p>No hay simulacros finalizados.</p></div>';
        return;
    }

    const list = items.slice(0, 5);
    const html = list.map(item => {
        const score = clampScore(item.total_score);
        const initials = (item.student_name || "A").split(/\s+/).filter(Boolean).slice(0, 2).map(part => part[0]).join("").toUpperCase() || "A";
        // Color thresholds: <20 red, 20-79 yellow, >=80 green
        const colorClass = score >= 80 ? "approved" : score >= 20 ? "warning" : "failed";
        const className = `result-score ${colorClass}`;

        return `
            <div class="recent-result">
                <div class="recent-student">
                   <div class="recent-avatar">${initials}</div>
                   <div class="recent-student-info">
                       <strong>${item.student_name || "Anónimo"}</strong>
                       <span>${item.category || "—"}</span>
                   </div>
                </div>
                <span class="${className}">${score.toFixed(1)}%</span>
            </div>
        `;
    }).join("");

    container.innerHTML = html;
}

function renderActivity(items) {
    const container = document.getElementById("activityChart");
    if (!container) return;
    container.replaceChildren();

    const recent = Array.isArray(items) ? items : [];
    if (!recent.length) {
        container.innerHTML = '<div class="chart-placeholder"><span>No hay actividad reciente.</span></div>';
        return;
    }

    const grouped = new Map();
    recent
        .filter(item => item.finished_at)
        .slice(0, 10)
        .forEach(item => {
            const date = new Date(item.finished_at);
            if (Number.isNaN(date.getTime())) return;
            const label = date.toLocaleDateString("es-CO", { day: "2-digit", month: "short" }).replace(".", "");
            grouped.set(label, (grouped.get(label) || 0) + 1);
        });

    const entries = [...grouped.entries()].slice(-7);
    if (!entries.length) {
        container.innerHTML = '<div class="chart-placeholder"><span>No hay actividad reciente.</span></div>';
        return;
    }

    const maxValue = Math.max(...entries.map(([, value]) => value), 1);
    const html = `
        <div class="activity-bars" style="display:flex; align-items:flex-end; gap:10px; height:160px; width:100%;">
            ${entries.map(([label, value]) => {
                const height = Math.max(12, (value / maxValue) * 100);
                return `
                   <div class="activity-bar" style="flex:1; min-width:0; display:flex; flex-direction:column; align-items:center; justify-content:flex-end; gap:8px; height:100%;">
                       <div style="width:100%; max-width:28px; height:${height}%; background:linear-gradient(180deg, #facc15 0%, #f5c400 100%); border-radius:8px 8px 0 0; box-shadow: inset 0 -2px 0 rgba(0,0,0,.06);"></div>
                       <span style="font-size:8px; color:#73736d; text-transform:capitalize;">${label}</span>
                   </div>
                `;
            }).join("")}
        </div>
    `;

    container.innerHTML = html;
}

function renderAlerts(modules) {
    const container = document.getElementById("alertsList");
    const counter = document.getElementById("alertCount");
    if (!container) return;

    const alerts = (Array.isArray(modules) ? modules : []).filter(item => clampScore(item.score) < 80);
    container.replaceChildren();
    if (counter) counter.textContent = String(alerts.length);

    if (alerts.length === 0) {
        container.innerHTML = '<div class="empty-state"><p>✅ No hay módulos por debajo del 80%.</p></div>';
        return;
    }

    alerts.forEach(item => {
        const p = document.createElement("p");
        p.textContent = `${MODULES[item.module] || item.module}: ${clampScore(item.score).toFixed(1)}%. Requiere refuerzo.`;
        container.appendChild(p);
    });
}

async function esperarAdmin() {
    for (let i = 0; i < 50 && !window.adminSession; i++) {
        await new Promise(resolve => setTimeout(resolve, 100));
    }
    if (!window.adminSession) throw new Error("Acceso administrativo no validado.");
}

function setText(id, value) {
    const el = document.getElementById(id);
    if (el) el.textContent = value;
}

function mostrarError(message) {
    const el = document.getElementById("adminError");
    if (el) {
        el.textContent = message;
        el.classList.remove("hidden");
    }
}