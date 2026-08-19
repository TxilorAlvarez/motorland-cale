import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { PDFDocument, StandardFonts, rgb } from "npm:pdf-lib@1.17.1";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const moduleLabels: Record<string, string> = {
  attitudes: "Actitudes y comportamiento vial",
  safe_mobility: "Movilidad segura y sostenible",
  traffic_rules: "Normativa de tránsito",
  signage_infrastructure: "Señalización e infraestructura",
  vehicle: "El vehículo",
};

function wrap(text: string, max = 88) {
  const words = text.replace(/\s+/g, " ").trim().split(" ");
  const lines: string[] = [];
  let line = "";
  for (const word of words) {
    if (`${line} ${word}`.trim().length > max && line) {
      lines.push(line);
      line = word;
    } else line = `${line} ${word}`.trim();
  }
  if (line) lines.push(line);
  return lines;
}

async function buildPdf(detail: any) {
  const pdf = await PDFDocument.create();
  const font = await pdf.embedFont(StandardFonts.Helvetica);
  const bold = await pdf.embedFont(StandardFonts.HelveticaBold);
  const attempt = detail.attempt;
  let page = pdf.addPage([595.28, 841.89]);
  let y = 800;
  const margin = 46;
  const line = (text: string, options: { bold?: boolean; size?: number; color?: ReturnType<typeof rgb> } = {}) => {
    const size = options.size ?? 10;
    if (y < 56) {
      page = pdf.addPage([595.28, 841.89]);
      y = 800;
    }
    page.drawText(text, { x: margin, y, size, font: options.bold ? bold : font, color: options.color ?? rgb(0.1, 0.12, 0.16) });
    y -= size + 5;
  };
  const paragraph = (text: string, options: { bold?: boolean; size?: number } = {}) =>
    wrap(text).forEach((item) => line(item, options));

  line("CEA Motorland · Resultado del simulador CALE", { bold: true, size: 17, color: rgb(0.05, 0.32, 0.55) });
  line(`Generado: ${new Date().toLocaleDateString("es-CO")}`, { size: 9 });
  y -= 10;
  line("Datos del aprendiz", { bold: true, size: 13 });
  line(`Nombre: ${[attempt.nombres, attempt.apellidos].filter(Boolean).join(" ") || "—"}`);
  line(`Documento: ${attempt.documento || "—"}    Matrícula: ${attempt.matricula || "—"}`);
  line(`Categoría: ${attempt.category || "—"}    Fecha: ${attempt.finished_at ? new Date(attempt.finished_at).toLocaleDateString("es-CO") : "—"}`);
  line(`Resultado: ${Number(attempt.total_score || 0).toFixed(1)}% · ${attempt.total_correct || 0}/${attempt.total_questions || 40} correctas · ${attempt.passed ? "APROBADO" : "REPROBADO"}`, { bold: true });
  y -= 10;
  line("Resultados por componente", { bold: true, size: 13 });
  for (const item of detail.modules || []) {
    line(`${moduleLabels[item.module] || item.module}: ${Number(item.score || 0).toFixed(1)}% (${item.correct_answers || 0}/${item.total_questions || 0})`);
  }
  y -= 10;
  line("Respuestas para reforzar", { bold: true, size: 13 });
  const incorrect = detail.incorrect_answers || [];
  if (!incorrect.length) line("No se registraron respuestas incorrectas.");
  for (const answer of incorrect) {
    paragraph(`${answer.question_order}. ${answer.question_text || "Pregunta"}`, { bold: true });
    line(`Respuesta marcada: ${answer.selected_option || "Sin responder"} · Correcta: ${answer.correct_option || "—"}`);
    if (answer.explanation) paragraph(`Explicación: ${answer.explanation}`);
    y -= 4;
  }
  return await pdf.save();
}

function bytesToBase64(bytes: Uint8Array) {
  let binary = "";
  const chunkSize = 0x8000;
  for (let i = 0; i < bytes.length; i += chunkSize) {
    binary += String.fromCharCode(...bytes.subarray(i, i + chunkSize));
  }
  return btoa(binary);
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  try {
    const authorization = req.headers.get("Authorization");
    if (!authorization) throw new Error("No autenticado");
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const userClient = createClient(supabaseUrl, anonKey, { global: { headers: { Authorization: authorization } } });
    const { data: { user }, error: userError } = await userClient.auth.getUser();
    if (userError || !user) throw new Error("No autenticado");

    const adminClient = createClient(supabaseUrl, serviceRoleKey);
    const { data: profile, error: profileError } = await adminClient.from("profiles").select("role").eq("id", user.id).single();
    if (profileError || !["admin", "superadmin"].includes(profile?.role)) throw new Error("No autorizado");

    const { attemptId } = await req.json();
    if (!attemptId || typeof attemptId !== "string") throw new Error("Intento inválido");
    // Se consulta con el JWT del administrador: la RPC vuelve a validar el rol
    // mediante auth.uid(), por lo que no se puede invocar con service role.
    const { data: rawDetail, error: detailError } = await userClient.rpc("admin_attempt_detail", { p_attempt: attemptId });
    if (detailError) throw detailError;
    const detail = Array.isArray(rawDetail) ? rawDetail[0] : rawDetail;
    if (!detail?.attempt?.correo) throw new Error("El aprendiz no tiene correo registrado");

    const pdf = await buildPdf(detail);
    const resendKey = Deno.env.get("RESEND_API_KEY");
    const sender = Deno.env.get("RESULTS_EMAIL_FROM");
    if (!resendKey || !sender) throw new Error("El correo transaccional no está configurado");
    const result = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { Authorization: `Bearer ${resendKey}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        from: sender,
        to: [detail.attempt.correo],
        subject: "Resultado del simulador CALE Motorland",
        html: `<p>Hola ${[detail.attempt.nombres, detail.attempt.apellidos].filter(Boolean).join(" ") || ""},</p><p>Adjuntamos el detalle en PDF de tu resultado del simulador CALE.</p>`,
        attachments: [{ filename: "resultado-simulador-cale.pdf", content: bytesToBase64(pdf) }],
      }),
    });
    if (!result.ok) throw new Error("El proveedor de correo rechazó el envío");
    return Response.json({ message: `PDF enviado a ${detail.attempt.correo}.` }, { headers: corsHeaders });
  } catch (error) {
    console.error(error);
    return Response.json({ error: error instanceof Error ? error.message : "Error inesperado" }, { status: 400, headers: corsHeaders });
  }
});
