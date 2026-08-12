document.addEventListener("DOMContentLoaded", async () => {
    const { data: { session } } = await supabaseClient.auth.getSession();
    if (!session) return location.replace("login.html");
    const id = new URLSearchParams(location.search).get("id");
    if (!id) return location.replace("dashboard.html");
    const [{ data: intento, error }, { data: profile }] = await Promise.all([
        supabaseClient.from("exam_attempts").select("category,started_at,finished_at,duration_seconds,total_questions,total_correct,total_score,passed,status").eq("id", id).single(),
        supabaseClient.from("profiles").select("nombres").eq("id", session.user.id).single()
    ]);
    if (error || !intento) return location.replace("dashboard.html");
    const nombre = (profile?.nombres || "Estudiante").split(/\s+/)[0]; const vencido = intento.status === "expired";
    document.getElementById("resultTitle").textContent = `${nombre}, este es tu resultado.`;
    document.getElementById("resultSubtitle").textContent = vencido ? "El tiempo de la evaluación terminó." : "Tu evaluación fue registrada correctamente.";
    document.getElementById("resultScore").textContent = `${Number(intento.total_score).toFixed(0)}%`;
    document.getElementById("resultPassed").textContent = intento.passed ? "APROBADO" : "NO APROBADO";
    document.getElementById("resultState").textContent = vencido ? "TIEMPO FINALIZADO" : "EVALUACIÓN FINALIZADA";
    document.getElementById("resultCategory").textContent = intento.category; document.getElementById("resultCorrect").textContent = `${intento.total_correct} / ${intento.total_questions}`;
    document.getElementById("resultDate").textContent = new Date(intento.finished_at || intento.started_at).toLocaleDateString("es-CO");
    const seconds = intento.duration_seconds || 0; document.getElementById("resultDuration").textContent = `${Math.floor(seconds / 60)} min ${seconds % 60} s`;
    document.getElementById("resultFeedback").textContent = intento.passed ? "Alcanzaste el mínimo de 80% requerido para este simulador." : "No alcanzaste el mínimo de 80%. Revisa los temas y continúa tu preparación.";
});
