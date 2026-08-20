const DETAIL_MODULES = { attitudes: "Actitudes y comportamiento vial", safe_mobility: "Movilidad segura y sostenible", traffic_rules: "Normativa de tránsito", signage_infrastructure: "Señalización e infraestructura", vehicle: "El vehículo" };

document.addEventListener("DOMContentLoaded", async () => {
    try {
        // Show immediate loading placeholders (helps UX when RPC takes time)
        const wrongListEl = document.getElementById('wrongAnswersList');
        if (wrongListEl) wrongListEl.innerHTML = '<div class="empty-state"><p>Cargando respuestas...</p></div>';
        const historyEl = document.getElementById('studentHistoryChart');
        if (historyEl) historyEl.innerHTML = '<div class="chart-placeholder"><span>Cargando historial...</span></div>';

        await esperarAdmin();
        const id = new URLSearchParams(location.search).get("id");
        if (!id) throw new Error("No se especificó el intento.");
        const { data, error } = await supabaseClient.rpc("admin_attempt_detail", { p_attempt: id });

        // Attach download button handler after admin session validated
        const dlBtn = document.getElementById('downloadPdfButton');
        if (dlBtn) dlBtn.addEventListener('click', () => downloadAttemptPdf());
        const emailBtn = document.getElementById('emailPdfButton');
        if (emailBtn) emailBtn.addEventListener('click', () => emailAttemptPdf(id));
        // Diagnostic logs to validate returned shape (kept concise)
        console.log('[ADMIN ATTEMPT] RPC response:', data);

        if (error) throw error;

        // Normalize payload: Supabase may return the jsonb object directly or an array containing it
        const payload = Array.isArray(data) && data.length ? data[0] : data || {};

        console.log('[ADMIN ATTEMPT] Normalized payload keys:', Object.keys(payload));
        console.log('[ADMIN ATTEMPT] Has attempt?:', !!payload.attempt, 'history length:', Array.isArray(payload.history) ? payload.history.length : typeof payload.history);

        if (!payload?.attempt) throw new Error("Intento no encontrado.");

        // Ensure history includes the current attempt when RPC filters out unfinished attempts
        // If history is empty but attempt exists, include it as the first entry (so first attempt appears)
        if ((!Array.isArray(payload.history) || payload.history.length === 0) && payload.attempt) {
            const a = payload.attempt;
            payload.history = [
                {
                    id: a.id || null,
                    total_score: (a.total_score !== undefined && a.total_score !== null) ? a.total_score : 0,
                    total_correct: (a.total_correct !== undefined && a.total_correct !== null) ? a.total_correct : 0,
                    total_questions: (a.total_questions !== undefined && a.total_questions !== null) ? a.total_questions : 0,
                    finished_at: a.finished_at || a.created_at || null,
                    passed: (a.passed !== undefined && a.passed !== null) ? a.passed : false,
                    created_at: a.created_at || null
                }
            ];
            console.log('[ADMIN ATTEMPT] Injected current attempt into history for display');
        }

        renderDetail(payload);
    } catch (error) {
        console.error("Error cargando aprendiz:", error);
        const el = document.getElementById("adminError");
        // Update placeholders so the UI doesn't look empty
        set('studentName', 'Cargando...');
        set('studentDocument', '—');
        set('studentEnrollment', '—');
        set('studentCategory', '—');
        set('studentAttempts', '—');
        set('studentScore', '—');
        set('studentCorrect', '—');
        set('studentIncorrect', '—');
        const historyEl = document.getElementById('studentHistoryChart');
        if (historyEl) historyEl.innerHTML = '<div class="chart-placeholder"><span>No fue posible cargar el historial.</span></div>';
        const wrongListEl = document.getElementById('wrongAnswersList');
        if (wrongListEl) wrongListEl.innerHTML = '<div class="empty-state"><p>No fue posible cargar las respuestas.</p></div>';
        if (el) {
            el.innerHTML = '';
            const p = document.createElement('p');
            p.textContent = 'No fue posible cargar el detalle del aprendiz.';
            el.appendChild(p);
            const btn = document.createElement('button');
            btn.textContent = 'Reintentar';
            btn.className = 'menu-button';
            btn.style.marginTop = '8px';
            btn.addEventListener('click', () => location.reload());
            el.appendChild(btn);
            el.classList.remove('hidden');
        }
    }
});

// Genera y descarga el mismo resumen de correcciones que se envía por correo.
function downloadAttemptPdf() {
    try {
        const Pdf = window.jspdf?.jsPDF;
        const detail = window._attemptDetail;
        if (!Pdf || !detail?.attempt) throw new Error('La biblioteca para generar PDF no está disponible.');
        const pdf = new Pdf({ unit: 'mm', format: 'a4' });
        const margin = 16;
        const width = 178;
        let y = 18;
        const page = () => { pdf.addPage(); y = 18; };
        const write = (text, { bold = false, size = 10 } = {}) => {
            pdf.setFont('helvetica', bold ? 'bold' : 'normal');
            pdf.setFontSize(size);
            const lines = pdf.splitTextToSize(String(text || '—'), width);
            if (y + lines.length * (size * 0.48) > 278) page();
            pdf.text(lines, margin, y);
            y += lines.length * (size * 0.48) + 3;
        };
        const a = detail.attempt;
        const fullName = `${a.nombres || ''} ${a.apellidos || ''}`.trim() || 'Aprendiz';
        pdf.setTextColor(18, 82, 130);
        write('CEA Motorland · Resumen de correcciones', { bold: true, size: 16 });
        pdf.setTextColor(30, 41, 59);
        write(`Aprendiz: ${fullName}`, { bold: true });
        write(`Documento: ${a.documento || '—'} · Categoría: ${a.category || '—'}`);
        write(`Resultado: ${Number(a.total_score || 0).toFixed(1)}% · ${a.total_correct || 0}/${a.total_questions || 40} correctas`);
        y += 3;
        write('Respuestas incorrectas y correcciones', { bold: true, size: 13 });
        const wrong = detail.incorrect_answers || [];
        if (!wrong.length) write('No se registraron respuestas incorrectas.');
        wrong.forEach(item => {
            const selected = option(item, item.selected_option);
            const correct = option(item, item.correct_option);
            write(`Pregunta ${String(item.question_order || '').padStart(2, '0')}: ${item.question_text || ''}`, { bold: true });
            write(`Respuesta marcada: ${selected}`);
            write(`Corrección: ${correct}`, { bold: true });
            if (item.explanation) write(`Explicación: ${item.explanation}`);
            y += 2;
        });
        pdf.save(`resumen-correcciones-${fullName.replace(/[^a-z0-9]+/gi, '-').toLowerCase()}.pdf`);
    } catch (error) {
        console.error('Error generando PDF:', error);
        alert('No fue posible generar el PDF. Revisa la consola para más detalle.');
    }
}

async function emailAttemptPdf(attemptId) {
    const button = document.getElementById('emailPdfButton');
    const recipient = window._currentAttempt?.correo;

    if (!recipient) {
        alert('El aprendiz no tiene un correo registrado para enviar el resultado.');
        return;
    }

    const confirmed = window.confirm(`Se enviará el PDF del resultado a ${recipient}. ¿Deseas continuar?`);
    if (!confirmed) return;

    const originalLabel = button?.textContent;
    if (button) {
        button.disabled = true;
        button.textContent = 'Enviando…';
    }

    try {
        const { data, error } = await supabaseClient.functions.invoke('email-attempt-pdf', {
            body: { attemptId }
        });
        if (error) throw error;
        alert(data?.message || `El PDF fue enviado a ${recipient}.`);
    } catch (error) {
        console.error('Error enviando PDF del resultado:', error);
        let detail = error?.message || 'Error desconocido';
        if (error?.context?.json) {
            try {
                const body = await error.context.json();
                detail = body?.error || detail;
            } catch (_) { /* La respuesta no tiene JSON legible. */ }
        }
        alert(`No fue posible enviar el PDF: ${detail}`);
    } finally {
        if (button) {
            button.disabled = false;
            button.textContent = originalLabel || '✉ Enviar PDF';
        }
    }
}

function escapeHtml(s) {
    if (!s) return '';
    return String(s).replace(/[&<>\"]/g, c => ({'&':'&amp;','<':'&lt;', '>':'&gt;', '"':'&quot;'}[c]));
}

window._currentAttempt = null;

function renderDetail(data) {
    try {
        window._currentAttempt = data.attempt;
        window._attemptDetail = data;
        const a = data.attempt || {};
        const name = `${a.nombres || ""} ${a.apellidos || ""}`.trim() || "Aprendiz";
        const total = Number(a.total_questions || 40);
        const correct = Number(a.total_correct || 0);
        const score = Number(a.total_score || 0);
        set("studentInitial", initials(name));
        set("studentName", name);
        set("studentDetails", a.correo || "--");
        set("studentDocument", a.documento || "--");
        set("studentEnrollment", a.matricula || "--");
        set("studentCategory", a.category || "--");
        set("studentAttempts", String((data.history || []).length));
        set("studentScore", `${score.toFixed(1)}%`);
        set("studentCorrect", correct);
        set("studentIncorrect", Math.max(0, total - correct));
        set("studentTime", formatTime(a.duration_seconds));
        set("studentLastDate", formatDate(a.finished_at));
        set("studentStatus", a.passed ? "APROBADO" : "REPROBADO");
        const ring = document.getElementById("studentScoreRing");
        if (ring) {
            ring.style.setProperty("--score", `${score}%`);
            const scoreColor = score >= 80 ? '#10b981' : score >= 20 ? '#f59e0b' : '#ef4444';
            ring.style.setProperty('--score-color', scoreColor);
        }

        // Render helpers wrapped individually so a failure in one does not block others
        try { renderModules(data.modules || []); } catch (e) { console.error('renderModules failed', e); }
        try { renderWrong(data.incorrect_answers || []); } catch (e) { console.error('renderWrong failed', e); const list = document.getElementById('wrongAnswersList'); if (list) { list.replaceChildren(); list.append(el('p','', 'No se registraron respuestas incorrectas.')); }}
        try { renderHistory(data.history || []); } catch (e) { console.error('renderHistory failed', e); const container = document.getElementById('studentHistoryChart'); if (container) { container.replaceChildren(); container.append(el('div','chart-placeholder','No hay historial de intentos.')); }}
        try { renderRecommendations(data.modules || []); } catch (e) { console.error('renderRecommendations failed', e); }

    } catch (error) {
        console.error('Error renderizando detalle del aprendiz:', error);
        const elErr = document.getElementById('adminError');
        if (elErr) { elErr.textContent = 'No fue posible renderizar el detalle del aprendiz.'; elErr.classList.remove('hidden'); }
    }
}

function renderModules(modules) {
    const map = new Map((modules || []).map(x => [x.module, x]));
    Object.entries(DETAIL_MODULES).forEach(([key]) => {
        const score = Number(map.get(key)?.score || 0);
        const name = key === "safe_mobility" ? "Mobility" : key === "traffic_rules" ? "Traffic" : key === "signage_infrastructure" ? "Signage" : key === "attitudes" ? "Attitude" : "Vehicle";
        set(`student${name}`, `${score.toFixed(1)}%`);
        const bar = document.getElementById(`student${name}Bar`);
        if (bar) {
            bar.style.width = `${score}%`;
            // Color thresholds: <20 red, 20-79 yellow, >=80 green
            const color = score >= 80 ? '#10b981' : score >= 20 ? '#f59e0b' : '#ef4444';
            bar.style.background = `linear-gradient(90deg, ${color} 0%, ${color} 100%)`;
        }
    });
}

function renderHistory(history) {
    const container = document.getElementById("studentHistoryChart");
    if (!container) return;

    // history is expected as newest first (admin_attempt_detail returns ordered by finished_at desc)
    const list = Array.isArray(history) ? history : [];
    if (list.length === 0) {
        container.innerHTML = '<div class="chart-placeholder"><span>No hay historial de intentos.</span></div>';
        return;
    }

    // Mostrar de izquierda a derecha desde el más antiguo hasta el actual.
    const items = list.slice(0, 10).reverse();
    let html = '<div class="history-vertical-chart">';

    for (let i = 0; i < items.length; i++) {
        const it = items[i];
        const score = Number(it.total_score || 0);
        const color = score >= 80 ? '#10b981' : score >= 20 ? '#f59e0b' : '#ef4444';
        const label = i === items.length - 1 ? 'Intento actual' : `Intento ${i + 1}`;
        const date = it.finished_at ? new Date(it.finished_at).toLocaleDateString('es-CO') : (it.created_at ? new Date(it.created_at).toLocaleDateString('es-CO') : '—');

        html += `
            <div class="history-vertical-item" style="--score:${Math.max(0, Math.min(score, 100))}%; --bar-color:${color};">
                <div class="history-vertical-bar-wrap">
                    <div class="history-vertical-bar" title="${score.toFixed(1)}%"></div>
                </div>
                <div>
                    <div class="history-vertical-score">${score.toFixed(1)}%</div>
                    <div class="history-vertical-label">${label}<br>${date}</div>
                </div>
            </div>
        `;
    }

    html += '</div>';
    container.innerHTML = html;
}

function renderRecommendations(modules) {
    const container = document.getElementById("studentRecommendations");
    if (!container) return;
    if (!modules || modules.length === 0) {
        container.innerHTML = '<div class="empty-state"><p>No hay módulos para analizar</p></div>';
        return;
    }
    const sorted = [...modules].sort((a, b) => Number(a.score || 0) - Number(b.score || 0));
    let html = '<div class="recommendations-list">';
    sorted.forEach((module, index) => {
        const name = DETAIL_MODULES[module.module] || module.module;
        const score = Number(module.score || 0);
        const color = score >= 70 ? '#10b981' : score >= 50 ? '#f59e0b' : '#ef4444';
        html += `
            <div class="recommendation-item" style="border-left: 4px solid ${color}; padding: 12px; margin-bottom: 8px; background: #f9fafb; border-radius: 4px;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <strong>${name}</strong>
                    <span style="font-weight: bold; color: ${color};">${score.toFixed(1)}%</span>
                </div>
                <p style="margin: 4px 0 0; font-size: 14px; color: #6b7280;">
                    ${score < 60 ? '🔴 Área crítica - requiere refuerzo inmediato.' : score < 80 ? '🟡 Puede mejorar con estudio adicional.' : '🟢 Buen desempeño.'}
                </p>
            </div>
        `;
    });
    html += '</div>';
    container.innerHTML = html;
    console.log("✅ Recomendaciones renderizadas con", modules.length, "módulos");
}

function renderWrong(items) {
    const list = document.getElementById("wrongAnswersList");
    const count = document.getElementById("wrongAnswerCount");
    if (count) count.textContent = items.length;
    if (!list) return;
    list.replaceChildren();
    if (!items.length) return list.append(el("p", "", "No se registraron respuestas incorrectas."));

    const isGenericSource = txt => {
        if (!txt) return false;
        const t = String(txt).toLowerCase();
        return /motorland|banco de 200|200 preguntas|material pedag[oó]gico|prep(araci)?on|cea motorland/.test(t);
    };

    const pedagogicalFallback = (itm) => {
        // Provide a short, generic pedagogical/technical explanation without inventing legal citations.
        const mod = DETAIL_MODULES[itm.module] || itm.module || 'este tema';
        if (itm.question_type === 'attitude' || (itm.module === 'attitudes')) {
            return 'Fundamento pedagógico: Esta pregunta busca promover comportamientos seguros y responsables en la vía. El objetivo es reforzar actitudes que reduzcan riesgos y protejan a usuarios vulnerables (peatones, ciclistas).';
        }
        // For technical/knowledge questions
        return `Fundamento técnico: Esta pregunta aborda conceptos de ${mod.toLowerCase()} que impactan en la seguridad y operación del vehículo. Estudia la relación entre la condición descrita y su efecto sobre el desempeño o la seguridad.`;
    };

    items.forEach(item => {
        const card = el("article", "wrong-answer-item");
        const heading = `Pregunta ${String(item.question_order || item.id || '').padStart(2, "0")} · ${DETAIL_MODULES[item.module] || item.module || ''}`;

        // Build explanation and foundation
        const rawExplanation = item.explanation ? String(item.explanation).trim() : '';
        const legalParts = [item.legal_source, item.legal_article, item.legal_reference].filter(Boolean).map(String);
        const hasLegal = legalParts.length > 0 && !legalParts.some(isGenericSource);

        let whyText = rawExplanation;
        let foundationText = '';
        let sourceText = '';

        if (rawExplanation) {
            whyText = rawExplanation;
        } else {
            // No explicit explanation in DB: provide a pedagogical fallback (not a legal citation)
            whyText = pedagogicalFallback(item);
        }

        if (hasLegal) {
            foundationText = 'Fundamento jurídico:\n' + legalParts.join(' · ');
            sourceText = legalParts.join(' · ');
        } else {
            // If there's no valid legal reference, show pedagogical/technical foundation only
            foundationText = 'Fundamento pedagógico/técnico:\n' + pedagogicalFallback(item);
            // If there are legal fields but they are generic (eg. banco de preguntas), do not present them as juridical source
            if (legalParts.length > 0 && !hasLegal) {
                sourceText = legalParts.join(' · '); // keep as source but not as juridical foundation
            }
        }

        // Build DOM
        card.append(
            el("strong", "", heading)
        );

        // Image (if present)
        if (item.image_url) {
            try {
                const img = document.createElement('img');
                img.src = item.image_url;
                img.alt = `Imagen pregunta ${item.question_order || ''}`;
                img.style.maxWidth = '100%';
                img.style.margin = '8px 0';
                img.style.borderRadius = '6px';
                img.onerror = () => { img.style.display = 'none'; };
                card.append(img);
            } catch (e) {
                console.warn('No fue posible renderizar imagen de la pregunta', e);
            }
        }

        card.append(
            el("p", "", item.question_text || ''),
            el("p", "", `Respondió: ${option(item, item.selected_option)}`),
            el("p", "", `Correcta: ${option(item, item.correct_option)}`)
        );

        // Why / explanation
        const whyNode = document.createElement('p');
        whyNode.style.marginTop = '8px';
        whyNode.textContent = '¿Por qué?';
        whyNode.style.fontWeight = '700';
        card.append(whyNode);

        const whyTextNode = document.createElement('p');
        whyTextNode.textContent = whyText;
        card.append(whyTextNode);

        // Foundation
        const foundationNode = document.createElement('p');
        foundationNode.style.marginTop = '6px';
        foundationNode.style.fontStyle = 'italic';
        foundationNode.textContent = foundationText;
        card.append(foundationNode);

        // Source - only if exists; if it's generic, still show but labeled as 'Fuente (material de preparación)'
        if (sourceText) {
            const src = document.createElement('small');
            if (hasLegal) {
                src.textContent = 'Fuente: ' + sourceText;
            } else {
                src.textContent = 'Fuente (material de preparación): ' + sourceText;
            }
            src.style.display = 'block';
            src.style.marginTop = '6px';
            card.append(src);
        }

        list.append(card);
    });
}

function option(item, letter) {
    return letter ? `${letter}. ${item[`option_${letter.toLowerCase()}`] || ""}` : "Sin responder";
}

async function esperarAdmin() {
    for (let i = 0; i < 50 && !window.adminSession; i++) {
        await new Promise(resolve => setTimeout(resolve, 100));
    }
    if (!window.adminSession) throw new Error("Acceso administrativo no validado.");
}

function set(id, value) {
    const node = document.getElementById(id);
    if (node) node.textContent = value;
}

function el(tag, className, text) {
    const node = document.createElement(tag);
    node.className = className;
    node.textContent = text || "";
    return node;
}

function initials(value) {
    return value.split(/\s+/).filter(Boolean).map(x => x[0]).slice(0, 2).join("").toUpperCase();
}

function formatTime(value) {
    return value ? `${Math.floor(value / 60)} min ${value % 60} s` : "--";
}

function formatDate(value) {
    return value ? new Date(value).toLocaleDateString("es-CO") : "--";
}
