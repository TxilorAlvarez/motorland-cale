-- Banco complementario B1/C1 y refuerzo mínimo A2.
-- Ejecutar después de examen.sql y preguntas_a2.sql. Evita repetir el seed por texto.
insert into public.exam_questions (question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)
select 'attitude','attitudes',array['B1','C1'], 'medium', q,
       'Actuar con prisa y asumir que los demás cederán.', 'Mantener atención, anticipar el riesgo y actuar con prudencia.', 'Continuar sin adaptar la conducción.', 'Responder de forma agresiva a otros usuarios.', 'B',
       'La conducción preventiva busca reducir el riesgo y proteger la vida.', 'Agencia Nacional de Seguridad Vial', 'No aplica', 'Principios de movilidad segura'
from unnest(array[
 'Ante una distracción que afecta la conducción, la decisión responsable es:',
 'Al percibir que una maniobra puede generar conflicto, debo:',
 'Cuando un usuario vulnerable está cerca de mi trayectoria, debo:',
 'Frente a una discusión en la vía, la conducta más segura es:',
 'Si las condiciones de la vía cambian inesperadamente, debo:',
 'Al transportar carga o pasajeros, una conducción responsable implica:',
 'Cuando no tengo visibilidad suficiente para una maniobra, debo:',
 'La experiencia al volante no justifica:',
 'Al compartir la vía con ciclistas, una actitud segura es:',
 'Ante la presión de otros conductores, debo:',
 'Una decisión de conducción sostenible y segura consiste en:',
 'Cuando observo un riesgo en la vía, mi prioridad debe ser:'
]) q
where not exists (select 1 from public.exam_questions e where e.question_text = q);

insert into public.exam_questions (question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)
select 'knowledge', module, array['B1','C1'], 'medium', question_text,
       a,b,c,d, correct, explanation, source, 'No aplica', reference
from (values
('vehicle','Antes de iniciar la marcha, una verificación preventiva debe incluir:','Revisar que los elementos esenciales de seguridad estén en condiciones.','Confiar únicamente en el sonido del motor.','Modificar dispositivos de seguridad.','Ignorar testigos del tablero.','A','La revisión preventiva permite detectar condiciones que afectan la seguridad.','Agencia Nacional de Seguridad Vial','Referencia formativa de mantenimiento preventivo'),
('vehicle','Los neumáticos en condiciones adecuadas contribuyen principalmente a:','La adherencia y el control del vehículo.','Aumentar la distracción.','Eliminar la necesidad de frenar.','Sustituir la señalización.','A','Los neumáticos son esenciales para la adherencia y estabilidad.','Agencia Nacional de Seguridad Vial','Referencia formativa de mantenimiento preventivo'),
('vehicle','Un testigo de advertencia encendido en el tablero requiere:','Revisar su significado y atenderlo antes de continuar si compromete la seguridad.','Cubrirlo para no verlo.','Acelerar para que se apague.','Ignorarlo siempre.','A','Los testigos informan condiciones que deben ser verificadas.','Agencia Nacional de Seguridad Vial','Referencia formativa de mantenimiento preventivo'),
('vehicle','El mantenimiento preventivo del vehículo busca:','Conservar condiciones seguras de funcionamiento.','Evitar toda revisión técnica.','Aumentar la velocidad máxima.','Reemplazar el seguro obligatorio.','A','El mantenimiento reduce fallas previsibles.','Agencia Nacional de Seguridad Vial','Referencia formativa de mantenimiento preventivo'),
('vehicle','Los espejos del vehículo deben ajustarse para:','Reducir puntos ciegos y observar el entorno.','Evitar mirar el entorno.','Sustituir la observación directa.','Ser usados solo al estacionar.','A','Los espejos apoyan la percepción del entorno.','Agencia Nacional de Seguridad Vial','Referencia formativa de conducción preventiva'),
('vehicle','Los frenos deben utilizarse de forma:','Progresiva y acorde con las condiciones de la vía.','Brusca en cualquier circunstancia.','Únicamente al final del trayecto.','Sin observar el entorno.','A','El frenado controlado ayuda a conservar la estabilidad.','Agencia Nacional de Seguridad Vial','Referencia formativa de conducción preventiva'),
('vehicle','Una carga mal asegurada puede:','Afectar la estabilidad y generar riesgo.','Mejorar el control del vehículo.','Reemplazar los dispositivos de seguridad.','No tener ningún efecto.','A','La carga debe mantenerse asegurada.','Agencia Nacional de Seguridad Vial','Referencia formativa de transporte seguro'),
('signage_infrastructure','Las señales de tránsito tienen como finalidad:','Orientar, regular y advertir para una circulación segura.','Decorar la vía.','Aplicar solo cuando hay autoridades.','Aumentar la velocidad.','A','La señalización organiza y comunica condiciones de la vía.','Manual de Señalización Vial de Colombia','No aplica','Manual de Señalización Vial vigente'),
('signage_infrastructure','Ante una señal reglamentaria, el conductor debe:','Cumplir la instrucción indicada.','Considerarla opcional.','Seguir únicamente a otros vehículos.','Ignorarla de noche.','A','Las señales reglamentarias comunican obligaciones o prohibiciones.','Manual de Señalización Vial de Colombia','No aplica','Manual de Señalización Vial vigente'),
('signage_infrastructure','Una señal preventiva informa principalmente sobre:','Una condición o peligro que exige precaución.','Una promoción comercial.','El valor de una multa.','El estado del motor.','A','Las señales preventivas advierten riesgos en la vía.','Manual de Señalización Vial de Colombia','No aplica','Manual de Señalización Vial vigente'),
('signage_infrastructure','La demarcación vial sirve para:','Guiar y ordenar la circulación.','Sustituir todas las señales.','Indicar solamente destinos turísticos.','Permitir cualquier maniobra.','A','Las marcas viales complementan la señalización.','Manual de Señalización Vial de Colombia','No aplica','Manual de Señalización Vial vigente'),
('signage_infrastructure','Al aproximarse a una zona escolar, corresponde:','Reducir la velocidad y aumentar la atención.','Acelerar para salir rápido.','Usar el carril contrario.','Ignorar a peatones.','A','Las zonas con usuarios vulnerables exigen especial precaución.','Agencia Nacional de Seguridad Vial','No aplica','Referencia formativa de usuarios vulnerables'),
('signage_infrastructure','Un semáforo en rojo indica:','Detenerse antes de la línea o sitio de detención.','Acelerar si no hay tráfico.','Continuar siempre.','Girar sin observar.','A','La luz roja ordena la detención.','Ley 769 de 2002','No aplica','Código Nacional de Tránsito'),
('signage_infrastructure','La infraestructura vial debe interpretarse junto con:','Las señales, marcas y condiciones reales del entorno.','La preferencia personal del conductor.','La prisa del trayecto.','La marca del vehículo.','A','La lectura integral de la vía permite anticipar riesgos.','Agencia Nacional de Seguridad Vial','No aplica','Referencia formativa de conducción preventiva'),
('signage_infrastructure','Cuando una señalización temporal modifica la circulación, se debe:','Atenderla y adaptar la conducción.','Ignorarla por ser temporal.','Aumentar la velocidad.','Circular por áreas cerradas.','A','La señalización temporal protege en zonas de trabajo o cambios viales.','Manual de Señalización Vial de Colombia','No aplica','Manual de Señalización Vial vigente')
) as v(module,question_text,a,b,c,d,correct,explanation,source,reference)
where not exists (select 1 from public.exam_questions e where e.question_text = v.question_text);

-- Completa los módulos restantes con preguntas de fundamento formativo equivalentes.
insert into public.exam_questions (question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)
select 'knowledge', m, array['B1','C1'], 'medium', (array['Al iniciar la marcha,','Al aproximarse a una intersección,','Cuando cambia el entorno vial,','Antes de una maniobra,','Ante usuarios vulnerables,','Con visibilidad reducida,','En condiciones de lluvia,'])[n] || ' en ' || m || ' una decisión segura consiste en:', 'Anticipar el riesgo y respetar las reglas aplicables.', 'Actuar sin observar el entorno.', 'Priorizar la rapidez sobre la seguridad.', 'Confiar en que otros resolverán el riesgo.', 'A', 'La prevención reduce la exposición al riesgo.', 'Agencia Nacional de Seguridad Vial', 'No aplica', 'Referencia formativa de movilidad segura'
from unnest(array['traffic_rules','safe_mobility']) m, generate_series(1,7) n
where not exists (select 1 from public.exam_questions e where e.question_text = (array['Al iniciar la marcha,','Al aproximarse a una intersección,','Cuando cambia el entorno vial,','Antes de una maniobra,','Ante usuarios vulnerables,','Con visibilidad reducida,','En condiciones de lluvia,'])[n] || ' en ' || m || ' una decisión segura consiste en:');

-- Refuerzo A2: el banco existente tenía seis preguntas en tres módulos.
insert into public.exam_questions (question_type,module,category,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation,legal_source,legal_article,legal_reference)
select 'knowledge', m, array['A2'], 'medium', 'Para motociclistas, en ' || m || ' la conducta segura consiste en:', 'Anticipar el riesgo y adaptar la conducción.', 'Acelerar ante cualquier situación.', 'Ignorar la señalización.', 'Confiar únicamente en la habilidad propia.', 'A', 'La conducción preventiva reduce riesgos.', 'Agencia Nacional de Seguridad Vial', 'No aplica', 'Referencia formativa para motociclistas'
from unnest(array['vehicle','signage_infrastructure','traffic_rules']) m
where not exists (select 1 from public.exam_questions e where e.question_text = 'Para motociclistas, en ' || m || ' la conducta segura consiste en:');
