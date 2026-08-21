import { readFileSync, writeFileSync } from "node:fs";

const [bankPath, situationsPath, outputPath] = process.argv.slice(2);
if (!bankPath || !situationsPath || !outputPath) {
    throw new Error("Uso: node tools/generate_exam_bank.mjs banco.txt situacionales.txt salida.sql");
}

const clean = value => value.replace(/\f/g, " ").replace(/\s+/g, " ").trim();
const escape = value => `'${String(value).replaceAll("'", "''")}'`;
const moduleFor = header => {
    const text = header.toUpperCase();
    if (text.includes("MOVILIDAD")) return "safe_mobility";
    if (text.includes("NORMAS")) return "traffic_rules";
    if (text.includes("SEÑALIZACIÓN")) return "signage_infrastructure";
    if (text.includes("VEHÍCULO")) return "vehicle";
    if (text.includes("MOTOCICLETA")) return "vehicle";
    return null;
};

function parseBank(text) {
    const questions = [];
    let module = null, current = null;
    const finish = () => {
        if (!current) return;
        const type = [41,42,43,44,45,46,47,48,49,50,91,92,93,94,95,96,97,98,99,100,128,129,130,131,132,133,134,135].includes(current.number) ? "attitude" : "knowledge";
        if (type === "attitude") {
            ["A", "B", "C", "D"].forEach((letter, index) => current.options[letter] = current.scale?.[index]);
            const answerIndex = current.scale?.findIndex(
                option => option.toUpperCase() === current.answer
            );
            current.answer = ["A", "B", "C", "D"][answerIndex];
        }
        if (!current.options.D) current.options.D = "Ninguna de las anteriores.";
        if (!current.answer || !current.options.A || !current.options.B || !current.options.C || !current.options.D) {
            console.error("Pregunta omitida", current.number, current.answer, current.options);
            return;
        }
        questions.push({
            ...current,
            module: type === "attitude" ? "attitudes" : module,
            type,
            categories: current.number >= 176 ? ["A2"] : ["A2", "B1", "C1"]
        });
    };
    for (const raw of text.split("\n")) {
        const line = clean(raw);
        const nextModule = moduleFor(line);
        if (/M[ÓO]DULO\s+\d+/i.test(line) && nextModule) { finish(); current = null; module = nextModule; continue; }
        const match = line.match(/^(\d+)\.\s+(.+)$/);
        if (match) { finish(); current = { number: Number(match[1]), prompt: match[2], options: {} }; continue; }
        if (!current || /^CEA MOTORLAND|^P[áa]gina \d+/i.test(line)) continue;
        const option = line.match(/^([ABC])\.\s+(.+)$/);
        const answer = line.match(/^Respuesta correcta:\s*(.+)$/i);
        if (option) current.options[option[1]] = option[2];
        else if (answer) current.answer = answer[1].toUpperCase();
        else if ([41,42,43,44,45,46,47,48,49,50,91,92,93,94,95,96,97,98,99,100,128,129,130,131,132,133,134,135].includes(current.number) && ["Muy en desacuerdo", "En desacuerdo", "De acuerdo", "Muy de acuerdo"].includes(line)) {
            current.scale = [...(current.scale || []), line];
        }
        else if (!current.answer) {
            const last = ["C", "B", "A"].find(key => current.options[key]);
            if (last) current.options[last] += ` ${line}`;
            else current.prompt += ` ${line}`;
        }
    }
    finish();
    return questions;
}

function parseSituations(text) {
    const questions = [];
    let current = null;
    const finish = () => {
        if (!current?.answer || !current.options.A || !current.options.B || !current.options.C) return;
        questions.push({ ...current, type: "attitude", module: "attitudes", categories: ["A2", "B1", "C1"] });
    };
    for (const raw of text.split("\n")) {
        const line = clean(raw);
        const match = line.match(/^(\d+)\.\s+(.+)$/);
        if (match) { finish(); current = { number: Number(match[1]), heading: match[2], situation: "", prompt: "", options: {} }; continue; }
        if (!current || /^CEA MOTORLAND|^P[áa]gina \d+/i.test(line)) continue;
        if (line.startsWith("Situación:")) current.situation += ` ${line.slice(10)}`;
        else if (line.startsWith("Pregunta:")) current.prompt += ` ${line.slice(9)}`;
        else {
            const option = line.match(/^([ABC])\.\s+(.+)$/);
        const answer = line.match(/^Respuesta correcta:\s*(.+)$/i);
            if (option) current.options[option[1]] = option[2];
        else if (answer) current.answer = answer[1].toUpperCase();
            else if (current.prompt && !current.answer) current.prompt += ` ${line}`;
            else if (!current.prompt) current.situation += ` ${line}`;
        }
    }
    finish();
    return questions.map(question => ({ ...question, prompt: `Situación: ${clean(question.situation)}\n\n${clean(question.prompt)}` }));
}

const bank = parseBank(readFileSync(bankPath, "utf8"));
const situations = parseSituations(readFileSync(situationsPath, "utf8"));
if (bank.length !== 200 || situations.length !== 40) throw new Error(`Extracción incompleta: banco=${bank.length}, situacionales=${situations.length}`);
const questions = [...bank, ...situations];
const rows = questions.map(question => {
    const source = question.heading ? "CEA Motorland - 40 preguntas situacionales tipo CALE" : "CEA Motorland - Banco de 200 preguntas CALE";
    const reference = "Manual de referencia para la conducción de vehículos — Agencia Nacional de Seguridad Vial (ANSV)";
    // No insertar frases pedagógicas en el campo explanation; dejar NULL para que el frontend muestre referencias legales explícitas.
    return `(${escape(question.type)},${escape(question.module)},ARRAY[${question.categories.map(escape).join(",")}],${escape("medium")},${escape(clean(question.prompt))},${escape(clean(question.options.A))},${escape(clean(question.options.B))},${escape(clean(question.options.C))},${escape("Ninguna de las anteriores.")},${escape(question.answer)},NULL,${escape(source)},NULL,${escape(reference)})`;
});
const sql = `-- Generado desde los dos PDF pedagógicos de CEA Motorland.\n-- No corresponde al banco oficial de preguntas del CALE.\ninsert into public.exam_questions (question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)\nselect * from (values\n${rows.join(",\n")}\n) as incoming(question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)\nwhere not exists (select 1 from public.exam_questions existing where existing.question_text = incoming.question_text);\n\n-- Comprobación posterior sugerida:\n-- select category_item, count(*) from exam_questions cross join unnest(category) category_item where active group by category_item;\n`;
writeFileSync(outputPath, sql);
