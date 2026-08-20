-- =============================================================================
-- BANCO DE PREGUNTAS MOTORLAND - 
-- CATEGORÍAS: A2, B1, C1 Y GENERAL
-- =============================================================================

INSERT INTO public.exam_questions 
(category, module, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, legal_source, legal_article, legal_reference, image_url)
VALUES

-- 1. [A2] Frenado de Emergencia
(
  array['A2'],
  'safe_mobility',
  '[A2] Durante un frenado de emergencia en motocicleta a velocidad de carretera, ¿cuál es la distribución de frenado recomendada para evitar la pérdida de control?',
  '100% en el freno trasero para evitar el vuelco.',
  'Aproximadamente 70% en el freno delantero y 30% en el trasero.',
  '50% en el freno delantero y 50% en el freno trasero.',
  'Usar únicamente el freno de motor bajando marchas.',
  'B',
  'En motocicletas, el freno delantero aporta aproximadamente el 70% de la capacidad de detención debido a la transferencia de peso hacia el eje delantero durante la desaceleración.',
  'Manual de Referencia para la Conducción de Vehículos',
  NULL,
  'Agencia Nacional de Seguridad Vial (ANSV)',
  '/assets/images/illustrations/a2_distribucion_frenado.jpg'
),

-- 2. [A2] Uso del Casco (Protección)
(
  array['A2'],
  'traffic_rules',
  '[A2] Además de la certificación técnica del casco, ¿cuál es una obligación legal insustituible para el conductor de motocicleta según la regulación vigente de uso?',
  'Llevar el visor levantado en todo momento.',
  'Que la cabeza quede completamente inmersa y el casco esté correctamente abrochado, sin el uso de dispositivos móviles entre la cabeza y el casco.',
  'Tener grabado el tipo de sangre en los laterales.',
  'Usar un casco de color idéntico al de la carrocería de la moto.',
  'B',
  'La normativa exige que el casco cubra la cabeza del usuario, esté asegurado por su sistema de retención y prohíbe explícitamente interponer sistemas de comunicación no integrados entre el casco y el cráneo.',
  'Condiciones de uso de casco',
  'Artículo 3',
  'Resolución 20203040023385 de 2020 / MinTransporte',
  '/assets/images/illustrations/a2_casco_uso_correcto.jpg'
),

-- 3. [SEÑALIZACIÓN - GENERAL] Señal Reglamentaria
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica la siguiente señal reglamentaria identificada con el código SR-01?',
  'Prohibido seguir adelante.',
  'Ceda el paso a los vehículos de la vía principal.',
  'Pare: Obligación de detener totalmente la marcha antes de la línea de detención.',
  'Reduzca la velocidad a 10 km/h.',
  'C',
  'La señal octagonal SR-01 (PARE) exige la detención total del vehículo en la intersección antes de continuar la marcha.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales Reglamentarias',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-01.png'
),

-- 4. [B1] Adelantamiento
(
  array['B1'],
  'traffic_rules',
  '[B1] De acuerdo con la Ley 769 de 2002, ¿por cuál lado se debe efectuar por regla general el adelantamiento de otro vehículo en una vía de doble sentido?',
  'Por la derecha en todos los casos.',
  'Por la izquierda, anunciando la maniobra con las luces direccionales.',
  'Por el berma si hay espacio suficiente.',
  'Por cualquiera de los dos lados siempre que se pite.',
  'B',
  'Todo conductor que vaya a adelantar a otro vehículo debe hacerlo por la izquierda, indicando la maniobra mediante las direccionales correspondientes.',
  'Código Nacional de Tránsito',
  'Artículo 60',
  'Ley 769 de 2002',
  NULL
),

-- 5. [B1] Distancia de Seguridad (CORREGIDA BAJO LEY JULIÁN ESTEBAN)
(
  array['B1'],
  'safe_mobility',
  '[B1] De acuerdo con los criterios modernos de seguridad vial de la ANSV y la Ley Julián Esteban, ¿cómo debe calcularse la distancia segura con el vehículo que antecede en carretera?',
  'Manteniendo una distancia fija de 10 metros sin importar la velocidad.',
  'Siguiendo la regla de los metros equivalente a la mitad de la velocidad del vehículo.',
  'Utilizando la regla de los 3 segundos de diferencia temporal para garantizar espacio de reacción.',
  'Apegándose al parachoques del vehículo delantero para aprovechar la aerodinámica.',
  'C',
  'La Ley 2251 de 2022 prioriza la distancia en tiempo/espacio dinámico. Las guías técnicas de la ANSV promueven la regla de los 3 segundos en condiciones secas para permitir una reacción y frenado seguros.',
  'Ley Julián Esteban',
  'Artículo 12',
  'Ley 2251 de 2022 / ANSV',
  '/assets/images/illustrations/b1_distancia_seguridad_segundos.jpeg'
),

-- 6. [C1] Licencia de Conducción
(
  array['C1'],
  'traffic_rules',
  '[C1] ¿Cuál es la vigencia de la licencia de conducción categoría C1 para conductores menores de 60 años?',
  '10 años.',
  '5 años.',
  '3 años.',
  '1 año.',
  'C',
  'Las licencias de conducción para vehículos de servicio público (categorías C) deben renovarse cada 3 años para personas menores de 60 años.',
  'Código Nacional de Tránsito',
  'Artículo 22',
  'Ley 769 de 2002',
  NULL
),

-- 7. [C1] Kit de Carretera y Equipo de Prevención
(
  array['C1'],
  'vehicle',
  '[C1] Además de los elementos básicos de carretera, ¿qué elemento de prevención contra incendios debe portar obligatoriamente un vehículo de servicio público C1?',
  'Extintor de agua a presión de 5 galones.',
  'Extintor de polvo químico seco con capacidad mínima vigente según la tipología del vehículo.',
  'No es obligatorio llevar extintor si se tiene seguro todo riesgo.',
  'Dos extintores de CO2 de 1 libra.',
  'B',
  'El equipo de prevención y seguridad exige un extintor de incendios con capacidad adecuada al tipo de vehículo y con fecha de carga vigente.',
  'Código Nacional de Tránsito',
  'Artículo 30',
  'Ley 769 de 2002',
  NULL
),

-- 8. [SEÑALIZACIÓN - GENERAL] Señal Preventiva
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es la función principal de las señales de tránsito de color amarillo con símbolos negros (Señales Preventivas)?',
  'Notificar limitaciones, prohibiciones o restricciones legales.',
  'Advertir al usuario sobre la existencia de un peligro o condición inesperada en la vía.',
  'Guiar al usuario hacia su destino o sitios de interés.',
  'Indicar zonas de obras y mantenimiento temporal.',
  'B',
  'Las señales preventivas (código SP) tienen como función advertir con antelación la presencia de un riesgo en la infraestructura o en el flujo vehicular.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señales Preventivas',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-01.png'
),

-- 9. [ACTITUDES - GENERAL] Alcohol y Conducción
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Cuál es la consecuencia legal inmediata ante la negativa de un conductor a someterse a las pruebas de alcoholemia u otra sustancia psicoactiva?',
  'Una amonestación verbal y la orden de parquear el vehículo durante dos horas.',
  'La imposición de la máxima multa descrita en la ley, la suspensión de la licencia de conducción entre 10 y 12 años, y la inmovilización del vehículo.',
  'La pérdida definitiva de la ciudadanía colombiana.',
  'La obligación de realizar un curso de conducción adicional de 5 horas.',
  'B',
  'La negativa a realizar las pruebas de embriaguez constituye por sí misma la sanción más severa del régimen de tránsito, incluyendo multas severas y la suspensión prolongada del pase de conducción.',
  'Código Nacional de Tránsito (Modificado por Ley 1696 de 2013)',
  'Artículo 150',
  'Ley 769 de 2002',
  NULL
),

-- 10. [C1] Control Operacional de Servicio Público
(
  array['C1'],
  'traffic_rules',
  '[C1] ¿Qué documento específico y obligatorio, adicional a los de un vehículo particular, debe portar el conductor de un vehículo de servicio público colectivo o individual?',
  'La tarjeta de control vigente expedida por la empresa afiliadora, ubicada en un lugar visible.',
  'El contrato de compraventa del vehículo.',
  'El carné de afiliación a un partido político.',
  'La hoja de vida del conductor firmada por el Ministerio de Trasporte.',
  'A',
  'Los vehículos de servicio público requieren la tarjeta de control operativa que contiene las tarifas vigentes y los datos de identificación del conductor y de la empresa de transporte.',
  'Estatuto Nacional de Transporte',
  'Artículo 34',
  'Ley 336 de 1996 y decretos reglamentarios',
  '/assets/images/illustrations/c1_tarjeta_control.png'
),

-- 11. [GENERAL] Límites de Velocidad Urbanos (Ley Julián Esteban)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'De acuerdo con la Ley 2251 de 2022 (Ley Julián Esteban), ¿cuál es el límite máximo de velocidad permitido para vehículos particulares en vías urbanas, salvo señalización en contrario?',
  '60 km/h.',
  '50 km/h.',
  '80 km/h.',
  '30 km/h.',
  'B',
  'La Ley 2251 de 2022 fijó el límite máximo de velocidad en zonas urbanas en 50 km/h para vehículos particulares y de servicio público, buscando reducir la severidad de los siniestros viales.',
  'Ley Julián Esteban',
  'Artículo 106 (Modificado)',
  'Ley 2251 de 2022 / Ley 769 de 2002',
  '/assets/images/signals/SR-30_50.png'
),

-- 12. [GENERAL] Velocidad en Zonas Escolares y Residenciales
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuál es el límite máximo de velocidad permitido en zonas escolares, residenciales y de proximidad a intersecciones según la regulación vigente?',
  '40 km/h.',
  '30 km/h.',
  '20 km/h.',
  '50 km/h.',
  'B',
  'En zonas de alta presencia de vulnerables (escolares, residenciales y zonas hospitalarias), el límite insustituible es de 30 km/h para garantizar la supervivencia en caso de atropellamiento.',
  'Ley Julián Esteban',
  'Artículo 106',
  'Ley 2251 de 2022 / Ley 769 de 2002',
  '/assets/images/signals/SR-30_30.png'
),

-- 13. [A2] Prenda Reflectiva en Motocicletas
(
  array['A2'],
  'traffic_rules',
  '¿En qué horario es obligatorio para los conductores de motocicleta y sus acompañantes el uso de chaleco o prenda reflectiva según la reglamentación nacional?',
  'Únicamente cuando esté lloviendo intensamente.',
  'Desde las 18:00 horas hasta las 06:00 horas del día siguiente, y siempre que la visibilidad sea escasa.',
  'Las 24 horas del día de manera ininterrumpida.',
  'Solo cuando transiten por autopistas nacionales.',
  'B',
  'El Código Nacional de Tránsito establece el uso obligatorio de prendas reflectivas visibles entre las 18:00 y las 06:00 horas para mejorar la conspicuidad del motociclista.',
  'Código Nacional de Tránsito',
  'Artículo 94',
  'Ley 769 de 2002',
  '/assets/images/illustrations/a2_prenda_reflectiva.png'
),

-- 14. [A2] Tránsito por Pasos Peatonales y Bermas
(
  array['A2'],
  'attitudes',
  '¿Está permitido que un motociclista circule por las aceras, ciclorrutas o bermas para adelantar el tráfico congestionado?',
  'Sí, siempre que no s upere los 20 km/h.',
  'Sí, únicamente en horas pico.',
  'No, está expresamente prohibido y constituye una infracción sujeta a inmovilización.',
  'Solo si lleva las luces de parqueo encendidas.',
  'C',
  'Los motociclistas deben transitar por los carriles destinados al tráfico vehicular general. Invadir andenes, ciclovías o bermas viola las normas de prelación y seguridad.',
  'Código Nacional de Tránsito',
  'Artículo 94 y 131',
  'Ley 769 de 2002',
  NULL
),

-- 15. [B1] Uso del Cinturón de Seguridad
(
  array['B1'],
  'traffic_rules',
  'En un vehículo particular (B1), ¿quiénes tienen la obligación legal de utilizar el cinturón de seguridad durante la marcha?',
  'Únicamente el conductor.',
  'El conductor y el copiloto exclusivamente.',
  'Todos los ocupantes del vehículo, tanto en los asientos delanteros como en los traseros.',
  'Solo los niños menores de 10 años.',
  'C',
  'Es obligatorio el uso del cinturón de seguridad para todos los ocupantes del vehículo. En los asientos traseros es exigible según el año de modelo de homologación del vehículo.',
  'Código Nacional de Tránsito',
  'Artículo 82',
  'Ley 769 de 2002',
  '/assets/images/illustrations/b1_cinturon_ocupantes.png'
),

-- 16. [B1] Sistemas de Retención Infantil (SRI)
(
  array['B1'],
  'safe_mobility',
  'De acuerdo con las recomendaciones de seguridad vial y la normativa de tránsito, ¿dónde y cómo deben viajar los niños menores de 10 años en un automóvil particular?',
  'En el asiento delantero usando el cinturón para adultos.',
  'En los asientos traseros, obligatoriamente con un Sistema de Retención Infantil (silla) adecuado a su peso y talla.',
  'En los brazos del copiloto debidamente sujetados.',
  'En el baúl del vehículo si es tipo Station Wagon.',
  'B',
  'Menores de 10 años no pueden viajar en el asiento delantero por riesgo mortal de activación del airbag y deben ir en sillas homologadas (SRI) en las plazas traseras.',
  'Código Nacional de Tránsito',
  'Artículo 82',
  'Ley 769 de 2002 / Guía ANSV',
  '/assets/images/illustrations/b1_silla_infantil.jpg'
),

-- 17. [C1] Inspección Preoperativa
(
  array['C1'],
  'vehicle',
  '¿Cuál es el objetivo principal de la revisión o inspección preoperativa diaria que debe ejecutar el conductor de servicio público C1?',
  'Verificar la limpieza exterior de la carrocería para mejorar la imagen institucional.',
  'Comprobar el funcionamiento de los sistemas críticos de seguridad (frenos, luces, llantas, fluidos) antes de iniciar el servicio.',
  'Calcular las ganancias netas de la jornada anterior.',
  'Evitar pagar peajes en carreteras nacionales.',
  'B',
  'La inspección preoperativa diaria es una obligación en los Planes Estratégicos de Seguridad Vial (PESV) para mitigar fallas mecánicas durante la prestación del servicio.',
  'Plan Estratégico de Seguridad Vial',
  'Paso 11 - Mantenimiento e Inspección',
  'Resolución 20223040040595 de 2022',
  '/assets/images/illustrations/c1_inspeccion_preoperativa.jpg'
),

-- 18. [C1] Horas de Conducción y Descanso
(
  array['C1'],
  'attitudes',
  'Para evitar la fatiga y el microsueño en la conducción de servicio público C1, ¿cuál es el tiempo máximo de conducción continua recomendado antes de realizar una pausa activa?',
  '8 horas seguidas sin parar.',
  'Entre 2 y 4 horas continuas de conducción, con pausas activas de al menos 15 minutos.',
  '12 horas continuas con ventanas abiertas.',
  'No hay límite mientras el conductor tome bebidas energizantes.',
  'B',
  'Las normativas del trabajo y las guías de la ANSV establecen que no se debe superar las 4 horas de conducción continua para prevenir la fatiga cognitiva y motora.',
  'Guía de Gestión de la Fatiga',
  'Sección Pausas Activas',
  'ANSV / Ministerio del Trabajo',
  NULL
),

-- 19. [SEÑALIZACIÓN - GENERAL] Demarcación Vial (Línea Amarilla Continua)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué significado tiene una línea longitudinal central continua de color amarillo trazada sobre la calzada?',
  'Indica que el flujo vehicular va en el mismo sentido y se puede cambiar de carril.',
  'Separa flujos de tráfico en sentidos opuestos y prohíbe totalmente el adelantamiento o la invasión del carril contrario.',
  'Indica zona de estacionamiento permitido.',
  'Es una línea decorativa de la carretera.',
  'B',
  'La línea continua amarilla separa sentidos opuestos de circulación y notifica la restricción absoluta de adelantar debido a la visibilidad limitada del tramo.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Demarcaciones Viales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_amarilla_continua.lpeg'
),

-- 20. [SEÑALIZACIÓN - GENERAL] Señal Informativa (SI)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es el color predominante del fondo en las señales que brindan información de servicios en la vía (hospitales, estaciones de servicio, restaurantes)?',
  'Amarillo.',
  'Rojo.',
  'Azul.',
  'Verde.',
  'C',
  'Las señales informativas de servicios generales tienen fondo azul con pictogramas blancos y negros, orientando al usuario sobre las facilidades del camino.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales Informativas',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SI-01.jpg'
),

-- 21. [A2] Frenado Combinado y ABS
(
  array['A2'],
  'vehicle',
  '¿Qué beneficio principal aporta el sistema de frenos antibloqueo (ABS) en una motocicleta durante un frenado brusco?',
  'Aumenta la velocidad máxima de la motocicleta.',
  'Evita que las ruedas se bloqueen o patinen, manteniendo el control de la dirección y la estabilidad.',
  'Hace que la moto frene automáticamente sin presionar las manetas.',
  'Reduce el consumo de combustible durante la detención.',
  'B',
  'El sistema ABS detecta el bloqueo inminente de la rueda y libera presión intermitentemente, permitiendo al motociclista mantener el control del manillar mientras desacelera.',
  'Reglamento Técnico de Frenos para Motocicletas',
  'Artículo 4',
  'Resolución 20223040037055 de 2022',
  '/assets/images/illustrations/a2_sistema_abs.jpeg'
),

-- 22. [A2] Transporte de Carga en Motocicletas
(
  array['A2'],
  'traffic_rules',
  '¿Cuál es la norma que rige el transporte de carga o paquetes en una motocicleta?',
  'Se puede transportar cualquier carga sin importar la dimensión.',
  'La carga no debe sobresalir de los extremos laterales del manillar ni dificultar la visibilidad o maniobrabilidad del conductor.',
  'Está prohibido llevar cualquier tipo de maleta o morral.',
  'Solo se puede llevar carga si se ata con cuerdas al casco.',
  'B',
  'El volumen de la carga en vehículos de dos ruedas no debe poner en riesgo la estabilidad del vehículo ni sobrepasar las dimensiones reglamentarias de la estructura.',
  'Código Nacional de Tránsito',
  'Artículo 94',
  'Ley 769 de 2002',
  NULL
),

-- 23. [B1] Fallo de Frenos en Bajada
(
  array['B1'],
  'safe_mobility',
  'Si experimenta una pérdida repentina de frenos por sobrecalentamiento mientras desciende una pendiente prolongada en automóvil, ¿cuál es la primera acción de control?',
  'Apagar el motor de inmediato y retirar la llave.',
  'Engranar marchas más bajas (freno de motor) y accionar progresivamente el freno de mano sin bloquear las ruedas.',
  'Saltar del vehículo en movimiento.',
  'Acelerar a fondo para buscar el final de la pendiente.',
  'B',
  'Reducir las marchas de la caja de cambios retiene el vehículo mediante la compresión del motor, reduciendo la velocidad de forma segura sin sobrecargar los frenos.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Técnicas de Conducción Preventiva',
  'ANSV',
  '/assets/images/illustrations/b1_freno_motor.jpg'
),

-- 24. [B1] Hidroplaneamiento (Aquaplaning)
(
  array['B1'],
  'safe_mobility',
  '¿Qué es el fenómeno de hidroplaneamiento o aquaplaning y cómo debe reaccionarse ante él?',
  'Es cuando los frenos se mojan; se debe acelerar para secarlos.',
  'Es la pérdida de contacto de los neumáticos con el asfalto por una película de agua; se debe desacelerar suavemente sin frenar intempestivamente ni girar el volante con brusquedad.',
  'Es una técnica para tomar curvas más rápido sobre mojado.',
  'Es el fallo del limpiaparabrisas durante una tormenta.',
  'B',
  'Al flotar el neumático sobre el agua, frenar o girar abruptamente causará un derrape incontrolable. Se debe mantener la dirección firme y soltar gradualmente el acelerador.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Conducción en Condiciones Adversas',
  'ANSV',
  '/assets/images/illustrations/b1_hidroplaneamiento.jpg'
),

-- 25. [C1] Prelación en Intersecciones no Señalizadas
(
  array['C1'],
  'traffic_rules',
  'En una intersección sin señalización ni semáforos, ¿cuál vehículo tiene la prioridad de paso de acuerdo con las reglas de prelación?',
  'El vehículo que vaya a mayor velocidad.',
  'El vehículo que ingrese por la vía de mayor jerarquía o, a igual jerarquía, el que se encuentre a la derecha.',
  'El vehículo de servicio público siempre, sin excepción.',
  'El vehículo de mayor tamaño.',
  'B',
  'El Código Nacional de Tránsito define la prelación según la clasificación de las vías (vía arterial sobre colectiva, etc.) y la regla de la derecha ante avenidas equivalentes.',
  'Código Nacional de Tránsito',
  'Artículo 105',
  'Ley 769 de 2002',
  NULL
),

-- 26. [C1] Planillas y Documentación de Carga/Pasajeros
(
  array['C1'],
  'traffic_rules',
  '¿Qué sanción aplica cuando un vehículo de servicio público C1 presta el servicio sin portar los documentos que sustentan la operación legal (como el extracto de contrato o tarjeta de operación)?',
  'Llamado de atención escrito.',
  'Imposición de comparendo e inmovilización inmediata del vehículo.',
  'Una multa equivalente a 1 salario mínimo sin inmovilización.',
  'Ninguna, si el conductor muestra su cédula.',
  'B',
  'Prestar servicio público sin la documentación de transporte habilitante constituye una infracción grave que acarrea la inmovilización del automotor.',
  'Código Nacional de Tránsito y Ley de Transporte',
  'Artículo 131 Infracción C.1',
  'Ley 769 de 2002 / Ley 336 de 1996',
  NULL
),

-- 27. [GENERAL] Rotondas o Glorietas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Quién tiene la prelación de paso al ingresar a una glorieta o rotonda de un solo carril si no hay señalización que indique lo contrario?',
  'El vehículo que va a ingresar a la glorieta.',
  'El vehículo que ya se encuentra transitando dentro de la glorieta.',
  'El vehículo de mayor tonelaje.',
  'El vehículo que pita primero.',
  'B',
  'Tiene la prelación de paso el vehículo que ya está circulando en el anillo de la glorieta sobre aquellos que pretenden acceder a ella.',
  'Código Nacional de Tránsito',
  'Artículo 105',
  'Ley 769 de 2002',
  '/assets/images/illustrations/glorieta_prelacion.jpeg'
),

-- 28. [GENERAL] Luces Direccionales y Antelación
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Con qué distancia mínima de anticipación debe un conductor accionar la luz direccional antes de realizar un giro o cambio de carril en zona urbana?',
  '5 metros antes.',
  '30 metros antes.',
  '100 metros antes.',
  'Justo en el momento en que se gira el volante.',
  'B',
  'En zonas urbanas, la señalización del giro debe realizarse con una antelación mínima de 30 metros para alertar a los demás usuarios de la vía.',
  'Código Nacional de Tránsito',
  'Artículo 67',
  'Ley 769 de 2002',
  '/assets/images/illustrations/uso_direccionales.jpeg'
),

-- 29. [A2] Uso de Luces en Motocicletas
(
  array['A2'],
  'traffic_rules',
  '¿Cuál es la obligación respecto al uso de la luz delantera en las motocicletas durante su circulación en el territorio nacional?',
  'Encenderla únicamente entre las 18:00 y las 06:00 horas.',
  'Mantenerla encendida todo el tiempo (24 horas) durante la marcha.',
  'Usarla solo en carreteras nacionales de doble sentido.',
  'Solo encenderla cuando no haya alumbrado público.',
  'B',
  'Por visibilidad y seguridad, todas las motocicletas deben transitar con la luz delantera proyector encendida las 24 horas del día.',
  'Código Nacional de Tránsito',
  'Artículo 86',
  'Ley 769 de 2002',
  NULL
),

-- 30. [A2] Superficies Deslizantes y Frenado
(
  array['A2'],
  'safe_mobility',
  'Al cruzar sobre demarcaciones pintadas en el suelo (pasos cebra) o tapas de alcantarillado en días lluviosos, ¿qué precaución principal debe tomar un motociclista?',
  'Acelerar fuertemente para pasar rápido.',
  'Inclinar la motocicleta al máximo sobre la pintura.',
  'Mantener la motocicleta vertical, evitar frenar o inclinar bruscamente sobre estas superficies de baja adherencia.',
  'Frenar únicamente con el freno delantero.',
  'C',
  'La pintura vial y las tapas metálicas reducen drásticamente el coeficiente de fricción cuando están húmedas, pudiendo causar una caída por pérdida de adherencia.',
  'Guía de Movilidad Segura para Motociclistas',
  'Superficies de Baja Adherencia',
  'ANSV',
  '/assets/images/illustrations/a2_superficies_deslizantes.jpeg'
),

-- 31. [B1] Luces Altas y Deslumbramiento
(
  array['B1'],
  'safe_mobility',
  'Al cruzar con otro vehículo que circula en sentido contrario durante la noche en carretera, ¿a qué distancia se deben cambiar las luces altas por luces bajas para evitar encandilar al otro conductor?',
  '50 metros antes.',
  '150 metros antes del cruce.',
  '500 metros antes.',
  'No es necesario cambiar las luces.',
  'B',
  'El cambio de luz alta a baja debe realizarse al menos a 150 metros del vehículo que se aproxima en sentido opuesto para prevenir el cegamiento temporal por deslumbramiento.',
  'Código Nacional de Tránsito',
  'Artículo 86',
  'Ley 769 de 2002',
  '/assets/images/illustrations/b1_cambio_luces.jpeg'
),

-- 32. [B1] Mantenimiento Preventivo de Llantas
(
  array['B1'],
  'vehicle',
  '¿Cuál es la profundidad mínima permitida del labrado (huella) de un neumático para garantizar un agarre seguro en piso húmedo antes de considerarse desgastada o lisa?',
  '0.5 mm.',
  '1.6 mm.',
  '5.0 mm.',
  '10.0 mm.',
  'B',
  'El límite técnico legal para la profundidad de las ranuras principales de la banda de rodamiento es de 1.6 mm. Por debajo de este nivel la llanta pierde capacidad de evacuación de agua.',
  'Código Nacional de Tránsito / Normas NTC',
  'Artículo 50',
  'Ley 769 de 2002',
  '/assets/images/illustrations/profundidad_llantas.jpg'
),

-- 33. [C1] Transporte de Pasajeros de Pie
(
  array['C1'],
  'traffic_rules',
  'En vehículos de servicio público C1 tipo automóvil, campero o camioneta de pasajeros, ¿está permitido llevar pasajeros de pie?',
  'Sí, siempre que se sostengan de los pasamanos.',
  'No, está rotundamente prohibido llevar pasajeros de pie en este tipo de vehículos.',
  'Sí, únicamente en trayectos urbanos cortos.',
  'Depende del cobro del pasaje.',
  'B',
  'Los vehículos de la categoría C1 (automóviles, camperos, camionetas) solo están homologados para transportar la capacidad de pasajeros sentados especificada en la licencia de tránsito.',
  'Estatuto Nacional de Transporte',
  'Capacidad de Pasajeros Homologada',
  'Ley 336 de 1996',
  NULL
),

-- 34. [C1] Puertas en Movimiento
(
  array['C1'],
  'traffic_rules',
  '¿Cuál es la prohibición expresa respecto a la apertura de puertas en vehículos de servicio público durante la prestación del servicio?',
  'Se pueden abrir para ventilar el vehículo.',
  'Está prohibido transitar con las puertas abiertas o permitir el ascenso/descenso de pasajeros con el vehículo en movimiento.',
  'Solo se deben cerrar cuando se toma una autopista.',
  'Queda a criterio de los pasajeros.',
  'B',
  'El movimiento del vehículo con puertas abiertas es una de las causas principales de caídas de ocupantes, tipificado como infracción grave.',
  'Código Nacional de Tránsito',
  'Artículo 91',
  'Ley 769 de 2002',
  NULL
),

-- 35. [SEÑALIZACIÓN - GENERAL] Señal Obligatoria de Ceda el Paso
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es la forma geométrica y significado de la señal reglamentaria SR-02 (Ceda el Paso)?',
  'Un círculo rojo que indica detención obligatoria.',
  'Un triángulo equilátero invertido con borde rojo y fondo blanco, que ordena ceder la preferencia de paso a los vehículos que circulan por la vía preferencial.',
  'Un cuadrado azul que indica parada de autobús.',
  'Un rombo amarillo que advierte curvas.',
  'B',
  'La señal triangular invertida SR-02 indica al conductor que debe aminorar la marcha o detenerse si es necesario para ceder el paso a los vehículos que transitan por la vía a la que se va a incorporar.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-02',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-02.jpg'
),

-- 36. [GENERAL] Distancia al Adelantar Ciclistas (Ley Julián Esteban)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'De acuerdo con la Ley 2251 de 2022 (Ley Julián Esteban), ¿cuál es la distancia lateral mínima que debe guardar cualquier vehículo motorizado al adelantar a un ciclista en la vía?',
  '0.5 metros.',
  '1.0 metro.',
  '1.5 metros.',
  '2.0 metros.',
  'C',
  'La Ley 2251 de 2022 establece que todo vehículo motorizado que pretenda adelantar a un ciclista debe mantener una distancia lateral mínima de 1.5 metros para evitar desestabilizarlo por la turbulencia del aire.',
  'Ley Julián Esteban',
  'Artículo 60 Parágrafo',
  'Ley 2251 de 2022 / Ley 769 de 2002',
  '/assets/images/illustrations/distancia_ciclista_1.5m.jpg'
),

-- 37. [A2] Puntos Ciegos de Vehículos Pesados
(
  array['A2'],
  'safe_mobility',
  '¿Por qué razón un motociclista nunca debe transitar pegado a los costados o justo detrás de un tractocamión o autobús de transporte de pasajeros?',
  'Porque el humo del escape puede dañar la pintura de la motocicleta.',
  'Porque ingresa a los amplios "puntos ciegos" (ángulos muertos) donde el conductor del vehículo pesado no puede verlo a través de sus espejos.',
  'Porque la motocicleta consume más combustible al ir detrás de un vehículo grande.',
  'Porque está prohibido andar a menos de 50 km/h cerca de camiones.',
  'B',
  'Los vehículos de gran tonelaje poseen extensas zonas ciegas alrededor de la carrocería. Si el motociclista no ve los espejos del camión, el camionero tampoco puede verlo a él.',
  'Guía de Movilidad Segura para Motociclistas',
  'Sección Puntos Ciegos',
  'ANSV',
  '/assets/images/illustrations/a2_puntos_ciegos_camion.jpeg'
),

-- 38. [A2] Frenado en Curva
(
  array['A2'],
  'safe_mobility',
  'Si una motocicleta necesita reducir la velocidad mientras toma una curva, ¿cuál es la técnica de conducción más segura para evitar la pérdida de adherencia?',
  'Presionar fuertemente el freno delantero manteniendo la moto inclinada al máximo.',
  'Ajustar la velocidad (frenar) ANTES de entrar a la curva; si es necesario corregir adentro, erguir suavemente la moto y aplicar ambos frenos de forma progresiva.',
  'Bloquear la rueda trasera para derrapar al estilo deportivo.',
  'Apagar el motor e ir en neutro.',
  'B',
  'Frenar con la motocicleta inclinada reduce drásticamente el agarre neumático disponible para el giro, provocando una caída por deslizamiento. La desaceleración principal debe hacerse en línea recta antes de la curva.',
  'Manual de Conducción Preventiva para Motociclistas',
  'Técnicas de Trazado de Curvas',
  'ANSV',
  '/assets/images/illustrations/a2_frenado_curva.png'
),

-- 39. [B1] Uso de Luces Exploradoras
(
  array['B1'],
  'traffic_rules',
  '¿Bajo qué condiciones está permitido el uso de luces exploradoras delanteras en un vehículo particular B1?',
  'En todo momento dentro de la ciudad para iluminar mejor las calles.',
  'Únicamente cuando existan condiciones severas de niebla o densidad de lluvia, y orientadas hacia el piso sin encandilar a otros conductores.',
  'Para sustituir los faros principales cuando estos se encuentren averiados.',
  'Solo cuando se transita en exceso de velocidad.',
  'B',
  'Las luces exploradoras no son de uso libre urbano; su diseño está destinado a penetrar la niebla densa o visibilidad extrema en carretera, debiendo proyectarse por debajo de la línea del horizonte vehicular.',
  'Código Nacional de Tránsito',
  'Artículo 86',
  'Ley 769 de 2002',
  NULL
),

-- 40. [B1] Frenado con ABS en Automóviles
(
  array['B1'],
  'vehicle',
  'Cuando se realiza un frenado a fondo en un automóvil equipado con sistema de frenos ABS y se siente una vibración o pulsación en el pedal, ¿qué debe hacer el conductor?',
  'Soltar el pedal de inmediato pensando que los frenos fallaron.',
  'Mantener la presión firme e ininterrumpida sobre el pedal del freno y maniobrar la dirección si es necesario.',
  'Poner la palanca de cambios en reversa.',
  'Bompear el pedal del freno repetidamente.',
  'B',
  'La pulsación en el pedal es la señal normal del sistema ABS modulando la presión de frenado para evitar el bloqueo. La instrucción correcta es no soltar el pedal y mantener la presión firme.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Sistemas de Seguridad Activa ABS',
  'ANSV',
  '/assets/images/illustrations/b1_frenado_abs_pedal.png'
),

-- 41. [C1] Tolerancia Cero de Alcohol en Servicio Público
(
  array['C1'],
  'attitudes',
  '¿Cuál es el nivel máximo de alcohol en sangre permitido para un conductor de vehículo de servicio público C1 según la legislación colombiana?',
  '0.20 gramos de etanol / 100 ml de sangre.',
  '0.00 gramos de etanol / 100 ml de sangre (Tolerancia Cero).',
  '0.50 gramos de etanol / 100 ml de sangre.',
  'Hasta dos cervezas no generan sanción.',
  'B',
  'La Ley 1696 de 2013 y las normas de tránsito imponen tolerancia cero (grado 0 de embriaguez desde 20 mg/100 ml) para todos los conductores, siendo especialmente rigurosa en conductores de servicio público.',
  'Ley de Embriaguez',
  'Artículo 1 y 5',
  'Ley 1696 de 2013 / Ley 769 de 2002',
  NULL
),

-- 42. [C1] Periodicidad de la Revisión Técnico-Mecánica
(
  array['C1'],
  'vehicle',
  '¿A partir de qué año contado desde su fecha de matrícula debe realizar la primera Revisión Técnico-Mecánica y de emisiones contaminantes un vehículo de servicio público C1?',
  'Al sexto (6°) año.',
  'Al segundo (2°) año.',
  'Al primer (1er) año.',
  'A los cinco (5) años.',
  'C',
  'A diferencia de los particulares (que la realizan al 5° año según la Ley 2294 de 2023), los vehículos de servicio público deben efectuar su primera revisión técnico-mecánica al cumplir el primer año de matrícula.',
  'Código Nacional de Tránsito',
  'Artículo 52 (Modificado)',
  'Ley 769 de 2002 / Ley 2294 de 2023',
  '/assets/images/illustrations/c1_revision_tecnicomecanica.png'
),

-- 43. [SEÑALIZACIÓN - GENERAL] Señal Reglamentaria de Prohibición de Giro
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica la señal reglamentaria identificada con la figura de una flecha curvada a la izquierda atravesada por una franja diagonal roja (SR-06)?',
  'Giro a la izquierda obligatorio.',
  'Prohibido girar a la izquierda.',
  'Vía en curva peligrosa a la izquierda.',
  'Permitido girar en U.',
  'B',
  'Las señales reglamentarias con un círculo de borde rojo y franja cruzada indican la prohibición explícita de la maniobra ilustrada; en este caso, prohíbe el giro a la izquierda.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales SR-06',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-06.png'
),

-- 44. [SEÑALIZACIÓN - GENERAL] Demarcación de Zona de Bloqueo (Malla Amarilla)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué significa la demarcación en retícula o malla de líneas amarillas diagonales pintada en el centro de una intersección (Zona de No Bloquear)?',
  'Zona reservada para el parqueo de taxis.',
  'Prohibición de detener el vehículo dentro de la cuadrícula si no se tiene espacio libre adelante, para evitar el bloqueo del cruce.',
  'Paso exclusivo para peatones.',
  'Área de velocidad máxima a 80 km/h.',
  'B',
  'La malla amarilla advierte que ningún vehículo debe quedar detenido dentro del cruce, incluso si el semáforo está en verde, si el tráfico adelante no le permite salir de la intersección.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Demarcaciones Viales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_malla_amarilla.png'
),

-- 45. [A2] Visor del Casco en Conducción Nocturna o Lluvia
(
  array['A2'],
  'safe_mobility',
  'De acuerdo con las buenas prácticas y reglamentación, ¿por qué está prohibido el uso de visores oscuros o polarizados en los cascos de motociclista durante la conducción nocturna?',
  'Porque el polarizado raya el casco fácilmente.',
  'Porque reduce drásticamente la transmisión luminosa y la agudeza visual del conductor, aumentando el riesgo de atropello o colisión.',
  'Porque no combina con la vestimenta nocturna.',
  'Porque impide que las cámaras de fotodetección identifiquen el rostro.',
  'B',
  'Los visores tintados o espejados están homologados exclusivamente para condiciones de alta radiación solar diurna. Usarlos de noche disminuye la visibilidad del entorno hasta en un 70%.',
  'Reglamento Técnico de Cascos',
  'Artículo 3',
  'Resolución 1080 de 2019 / Res. 20203040023385',
  '/assets/images/illustrations/a2_visor_transparente_noche.png'
),

-- 46. [A2] Sistema de Escape y Emisión de Ruidos
(
  array['A2'],
  'vehicle',
  '¿Está permitido modificar el sistema de escape de una motocicleta instalando resonadores o retirando el silenciador original (DB Killer)?',
  'Sí, siempre que no afecte la velocidad.',
  'No, genera contaminación auditiva por encima de los decibelios permitidos y altera las emisiones contaminantes del motor.',
  'Sí, porque ayuda a que los otros vehículos escuchen la moto.',
  'Solo si la motocicleta es de cilindraje superior a 500 cc.',
  'B',
  'Modificar el tubo de escape anulando los silenciadores viola las normas ambientales de emisión de ruidos y gases, siendo sujeto de comparendo e inmovilización (Infracción D.17/C.29).',
  'Código Nacional de Tránsito y Código Ambiental',
  'Artículo 104 y 131',
  'Ley 769 de 2002',
  NULL
),

-- 47. [B1] Adelantamiento en Puentes y Curvas
(
  array['B1'],
  'traffic_rules',
  '¿En cuál de los siguientes lugares está rotundamente prohibido realizar maniobras de adelantamiento a otros vehículos?',
  'En rectas con visibilidad superior a 500 metros.',
  'En puentes, curvas de visibilidad reducida, bocacalles, pasos a nivel y túneles.',
  'En vías de tres carriles en un solo sentido.',
  'En autopistas pavimentadas de doble calzada.',
  'B',
  'El Artículo 68 del Código Nacional de Tránsito prohíbe adelantar en zonas donde la falta de visión del carril opuesto o la infraestructura (puentes, túneles) generen un riesgo inminente de choque frontal.',
  'Código Nacional de Tránsito',
  'Artículo 68',
  'Ley 769 de 2002',
  '/assets/images/signals/prohibicion_adelantar_puente.png'
),

-- 48. [B1] Uso de Luces Estacionarias (Parqueo)
(
  array['B1'],
  'traffic_rules',
  '¿Cuál es el uso legal correcto de las luces estacionarias (intermitentes de parqueo)?',
  'Para circular en exceso de velocidad en caso de afán.',
  'Para indicar que el vehículo se encuentra detenido, varado o realizando una parada de emergencia en la vía.',
  'Para adelantar por la derecha en autopistas.',
  'Para transitar dentro de túneles cuando hay tráfico continuo.',
  'B',
  'Las luces de parqueo notifican la inmovilidad del vehículo o un estado de emergencia; no deben usarse para transitar de manera continua en flujo normal de tráfico.',
  'Código Nacional de Tránsito',
  'Artículo 86',
  'Ley 769 de 2002',
  NULL
),

-- 49. [C1] Transporte de Mercancías Peligrosas o Químicos en Microbuses
(
  array['C1'],
  'traffic_rules',
  '¿Es legal transportar bombonas de gas propano, gasolina en pimpinas o sustancias inflamables dentro del compartimento de pasajeros de un microbús o colectivo de servicio público?',
  'Sí, si van amarradas en la parte trasera.',
  'No, está prohibido transportar sustancias peligrosas o inflamables junto a los pasajeros por riesgo de intoxicación o explosión.',
  'Sí, siempre que el viaje sea corto.',
  'Solo si se cobra un pasaje adicional por el equipaje.',
  'B',
  'El transporte de pasajeros y de mercancías peligrosas o inflamables es incompatible en la misma cabina; está regulado bajo normativas estrictas de materiales peligrosos.',
  'Estatuto Nacional de Transporte',
  'Decreto 1079 de 2015',
  'Decreto Único Reglamentario del Sector Transporte',
  NULL
),

-- 50. [C1] Capacidad Máxima de Pasajeros
(
  array['C1'],
  'traffic_rules',
  '¿Dónde se encuentra registrada legalmente la capacidad máxima de pasajeros sentados que puede transportar un vehículo C1?',
  'En la factura de compra del vehículo.',
  'En la Licencia de Tránsito (Tarjeta de Propiedad) del vehículo.',
  'En la cédula de ciudadanía del propietario.',
  'En el SOAT únicamente.',
  'B',
  'La Licencia de Tránsito es el documento oficial expedido por el RUNT que especifica las características técnicas del automotor, incluyendo la capacidad de pasajeros permitida.',
  'Código Nacional de Tránsito',
  'Artículo 38',
  'Ley 769 de 2002',
  '/assets/images/illustrations/c1_tarjeta_propiedad_pasajeros.png'
),

-- 51. [SEÑALIZACIÓN - GENERAL] Señal Preventiva de Curva Peligrosa
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué advierte la señal preventiva con símbolo de flecha en ángulo pronunciado hacia la derecha (SP-01)?',
  'La obligación de girar a la derecha inmediatamente.',
  'La proximidad de una curva horizontal pronunciada hacia la derecha que exige reducir la velocidad.',
  'El inicio de una vía de tres carriles.',
  'Una zona de parqueo permitido a la derecha.',
  'B',
  'Las señales preventivas SP-01 alertan al conductor sobre el cambio brusco en la alineación horizontal de la vía, recomendando reducir la marcha antes de ingresar al trazado.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señal SP-01',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-01.png'
),

-- 52. [SEÑALIZACIÓN - GENERAL] Señal Informativa de Primeros Auxilios
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué servicio indica la señal informativa con fondo azul y el ícono de una cruz blanca o roja sobre un fondo cuadrado (SI-05)?',
  'Un puesto de control policial.',
  'Un centro de atención médica o puesto de primeros auxilios cercano.',
  'Una iglesia o centro religioso.',
  'Una droguería veterinaria.',
  'B',
  'Las señales de servicios generales SI-05 informan la presencia de un centro asistencial de salud para emergencias médicas sobre la ruta.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales Informativas',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SI-05.png'
),

-- 53. [A2] Técnica de Mirada en Conducción de Motocicletas
(
  array['A2'],
  'safe_mobility',
  '¿Hacia dónde debe dirigir la mirada un motociclista al momento de efectuar un giro o tomar una curva de radio cerrado?',
  'Fijamente hacia la rueda delantera de la moto.',
  'Hacia el punto de salida de la curva o lugar adonde se desea dirigir el vehículo (visión periférica y lejana).',
  'Hacia el espejo retrovisor izquierdo continuamente.',
  'Hacia los vehículos que vienen detrás.',
  'B',
  'El principio de orientación espacial en motocicleta establece que "la moto va hacia donde se dirige la mirada". Fijar la vista en el obstáculo o la rueda provoca salirse de la trayectoria deseada.',
  'Guía de Movilidad Segura para Motociclistas',
  'Sección Técnicas de Control',
  'ANSV',
  '/assets/images/illustrations/a2_tecnica_mirada_curva.png'
),

-- 54. [A2] Inspección de la Cadena de Transmisión
(
  array['A2'],
  'vehicle',
  '¿Cuál es el riesgo mecánico y de seguridad vial de transitar con la cadena de transmisión de la motocicleta demasiado holgada (destensada)?',
  'Aumentar la potencia del motor en subidas.',
  'Que la cadena se salga de la corona (catalina) o se trabe en la rueda trasera, provocando el bloqueo intempestivo de la rueda y una caída grave.',
  'Reducir el consumo de gasolina a la mitad.',
  'Que los frenos de disco dejen de funcionar.',
  'B',
  'Una tensión incorrecta en la cadena puede provocar el descarrilamiento de la misma y el estancamiento inmediato de la tracción trasera, causando pérdida total de equilibrio.',
  'Manual de Mantenimiento Preventivo de Motocicletas',
  'Sistemas de Transmisión Secundaria',
  'ANSV',
  '/assets/images/illustrations/a2_tension_cadena.png'
),

-- 55. [B1] Uso Correcto del Apoyacabezas (Asientos)
(
  array['B1'],
  'safe_mobility',
  '¿Cuál es la función principal de seguridad pasiva del apoyacabezas instalado en las sillas de un automóvil?',
  'Servir como cojín para descansar o dormir durante viajes largos.',
  'Prevenir el traumatismo cervical ("latigazo cervical") reteniendo la cabeza en caso de un choque por alcance trasero.',
  'Mejorar la estética y tapicería interior del vehículo.',
  'Proteger los hombros ante un choque lateral.',
  'B',
  'El apoyacabezas ajustado a la altura de la parte superior de las orejas evita que la cabeza sufra una hiperextensión brusca hacia atrás cuando el vehículo es impactado por la parte posterior.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Sistemas de Seguridad Pasiva',
  'ANSV',
  '/assets/images/illustrations/b1_apoyacabezas_latigazo.png'
),

-- 56. [B1] Encendido del Motor y Emisiones
(
  array['B1'],
  'attitudes',
  '¿Por qué se debe evitar mantener el motor encendido en espacios cerrados o garajes sin ventilación?',
  'Porque el motor consume más aceite de lo normal.',
  'Por la acumulación de Monóxido de Carbono (CO), un gas inodoro y altamente tóxico que puede causar la muerte por asfixia.',
  'Porque se dañan los sensores del limpiaparabrisas.',
  'Porque se descarga la batería del vehículo.',
  'B',
  'Los gases de escape contienen monóxido de carbono, el cual desplaza el oxígeno en la sangre sin generar síntomas inmediatos visibles, provocando intoxicación letal en recintos cerrados.',
  'Manual de Mecánica Básica y Seguridad',
  'Gases de Combustión',
  'ANSV',
  NULL
),

-- 57. [C1] Tarjeta de Operación de Servicio Público
(
  array['C1'],
  'traffic_rules',
  '¿Qué entidad o autoridad emite la Tarjeta de Operación para un vehículo de servicio público que presta servicio en una ruta legalmente habilitada?',
  'La Alcaldía Municipal o el Ministerio de Transporte a través de la empresa de transporte a la cual está afiliado el vehículo.',
  'Cualquier centro de enseñanza automovilística.',
  'El concesionario que vendió el vehículo.',
  'El sindicato de conductores.',
  'A',
  'La Tarjeta de Operación es el documento expedido por la autoridad de transporte competente que autoriza a un vehículo de servicio público a prestar el servicio bajo la empresa habilitada.',
  'Estatuto Nacional de Transporte',
  'Decreto 1079 de 2015',
  'Ministerio de Transporte',
  '/assets/images/illustrations/c1_tarjeta_operacion.png'
),

-- 58. [C1] Estacionamiento de Servicio Público en Vía
(
  array['C1'],
  'traffic_rules',
  '¿Está permitido que un microbús de servicio público C1 se detenga a recoger o dejar pasajeros en la mitad de la calle o sobre el carril central?',
  'Sí, siempre que coloque las luces estacionarias.',
  'No, los ascensos y descensos deben realizarse obligatoriamente junto al andén derecho y únicamente en los paraderos autorizados.',
  'Sí, cuando el pasajero tenga afán.',
  'Depende del tráfico que venga atrás.',
  'B',
  'Parar en medio de la calzada expone al usuario a ser atropellado por otros vehículos que transitan por el carril contiguo e interrumpe de forma peligrosa el flujo vehicular.',
  'Código Nacional de Tránsito',
  'Artículo 91',
  'Ley 769 de 2002',
  NULL
),

-- 59. [SEÑALIZACIÓN - GENERAL] Señal Reglamentaria de Velocidad Máxima
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué ordena una señal circular de borde rojo con el número 50 en el centro (SR-30 con texto 50)?',
  'Mínimo de velocidad permitido a 50 km/h.',
  'Límite máximo de velocidad permitido en ese tramo de la vía a 50 km/h.',
  'Distancia máxima de parqueo a 50 metros.',
  'Peso máximo permitido de 50 toneladas.',
  'B',
  'La señal SR-30 establece la restricción reglamentaria de velocidad máxima permitida. Transitar por encima de dicho número acarrea comparendo por exceso de velocidad.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-30',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-30_50.png'
),

-- 60. [SEÑALIZACIÓN - GENERAL] Demarcación de Flechas de Dirección
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indicación sobre la calzada representan las flechas blancas de color reflectivo pintadas dentro de un carril?',
  'La velocidad recomendada para ese carril.',
  'La dirección o sentido obligatorio que debe seguir el vehículo que transita por ese carril específico.',
  'El lugar exclusivo para detenerse a descansar.',
  'La proximidad de un peaje.',
  'B',
  'Las flechas de orientación de carril notifican las maniobras permitidas (seguir de frente, girar a la izquierda/derecha) para los vehículos posicionado en dicho carril.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Demarcaciones Viales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_flecha_carril.png'
),

-- 61. [A2] Uso del Calzado Adecuado para Motociclistas
(
  array['A2'],
  'attitudes',
  '¿Por qué razón técnica y de seguridad no se debe conducir una motocicleta utilizando sandalias, chancletas o calzado destalonado?',
  'Porque el viento refresca demasiado los pies.',
  'Porque reduce el agarre sobre los mandos de pedal (freno y cambios), y deja expuestos los tobillos y pies a quemaduras o amputaciones en caídas.',
  'Porque acelera el desgaste de los posapiés de goma.',
  'Porque está prohibido por las marcas de motocicletas.',
  'B',
  'El calzado para motociclista debe ser cerrado, preferentemente botas que protejan el tobillo, proporcionando fricción para operar los pedales y blindaje térmico/mecánico.',
  'Guía de Equipamiento de Protección Personal',
  'Sección Calzado de Seguridad',
  'ANSV',
  '/assets/images/illustrations/a2_calzado_proteccion.png'
),

-- 62. [A2] Reacción ante Presencia de Aceite en la Calzada
(
  array['A2'],
  'safe_mobility',
  'Si al transitar en motocicleta observa una mancha brillante o irisada de combustible/aceite sobre la vía mojada, ¿cómo debe proceder?',
  'Girar fuertemente para esquivarla a última hora.',
  'Mantener la moto completamente erguida, soltar suavemente el acelerador, NO accionar frenos sobre la mancha y cruzar con la inercia.',
  'Clavar el freno trasero inmediatamente.',
  'Acelerar a fondo para derrapar sobre la mancha.',
  'B',
  'Tocar los frenos o cambiar la trayectoria sobre una mancha de aceite causa la pérdida instantánea del coeficiente de fricción de las llantas, derivando en una caída inminente.',
  'Manual de Conducción Preventiva para Motociclistas',
  'Maniobras de Emergencia',
  'ANSV',
  NULL
),

-- 63. [B1] Espejos Retrovisores y Ajuste Correcto
(
  array['B1'],
  'safe_mobility',
  '¿Cómo se deben ajustar los espejos retrovisores laterales de un automóvil para minimizar los puntos ciegos?',
  'Ajustarlos de modo que el costado del propio vehículo ocupe la mitad del espejo.',
  'Desplazarlos hacia afuera de manera que el costado del vehículo apenas sea visible en el borde interior del espejo, ampliando la visión del carril adyacente.',
  'Apuntarlos directamente hacia el suelo para ver la línea de parqueo.',
  'Orientarlos hacia el cielo para evitar los encandilamientos nocturnos.',
  'B',
  'Si el espejo muestra demasiado de la carrocería del carro, se desperdicia área útil de visión hacia el punto ciego lateral donde transitan otros vehículos o motocicletas.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Ajuste Ergonomía y Visibilidad',
  'ANSV',
  '/assets/images/illustrations/b1_ajuste_espejos.png'
),

-- 64. [B1] Cambio de Llanta Pinchada en Vía Pública
(
  array['B1'],
  'traffic_rules',
  'Al sufrir una pinchadura en vía pública que obligue a cambiar la rueda, ¿a qué distancia mínima del vehículo se deben colocar los triángulos o conos de señalización de peligro?',
  'A 1 metro.',
  'Entre 30 y 100 metros atrás del vehículo (según sea zona urbana o carretera) para advertir con tiempo al tráfico saliente.',
  'Pegados directamente a la defensa trasera.',
  'No se requieren si se encienden las luces de parqueo.',
  'B',
  'El Artículo 30 del Código Nacional de Tránsito exige ubicar los dispositivos de señalización reflectivos a una distancia que garantice que los vehículos que se aproximan tengan tiempo de desacelerar.',
  'Código Nacional de Tránsito',
  'Artículo 30',
  'Ley 769 de 2002',
  '/assets/images/illustrations/b1_posicion_triangulos_emergencia.png'
),

-- 65. [C1] Extintor de Incendios en Servicio Público
(
  array['C1'],
  'vehicle',
  '¿Cuál es la verificación mínima requerida sobre el extintor de incendios de un vehículo de servicio público C1 durante la revisión preoperativa?',
  'Verificar únicamente que el color de la botella sea rojo.',
  'Comprobar que el manómetro marque en la zona verde (presión adecuada), que el sello de seguridad esté intacto y que la fecha de vencimiento esté vigente.',
  'Golpear la botella para verificar si suena llena.',
  'Descargar un poco de gas para probar si funciona.',
  'B',
  'Un extintor desinflado o vencido es inútil durante una conato de incendio en el motor o sistema eléctrico. La aguja en zona verde certifica la presión de disparo.',
  'Código Nacional de Tránsito',
  'Artículo 30',
  'Ley 769 de 2002 / Normas NTC',
  '/assets/images/illustrations/extintor_manometro.png'
),

-- 66. [C1] Estado de los Neumáticos en Servicio Público
(
  array['C1'],
  'vehicle',
  '¿Está permitido el uso de llantas regrabadas (reacondicionadas manualmente en la banda de rodamiento sin proceso industrial) en el eje delantero de un vehículo de servicio público?',
  'Sí, porque ahorra costos a la empresa.',
  'No, está prohibido por alto riesgo de estallido o desprendimiento del labrado.',
  'Sí, únicamente durante la temporada seca.',
  'Solo si la velocidad no supera los 60 km/h.',
  'B',
  'Las llantas del eje direccional/delantero deben ser originales y en perfecto estado. El regrabado artesanal debilita la estructura de lonas provocando estallidos catastróficos.',
  'Código Nacional de Tránsito y Reglamentos Técnicos',
  'Artículo 50',
  'Ley 769 de 2002',
  NULL
),

-- 67. [SEÑALIZACIÓN - GENERAL] Señal Reglamentaria de Altura Máxima Permitida
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué restricción impone una señal circular reglamentaria que muestra dos triángulos apuntando verticalmente hacia un número como "4.1 m" (SR-28)?',
  'Velocidad máxima de 4.1 km/h.',
  'Altura máxima permitida para los vehículos que pretendan transitar o ingresar por esa vía o estructura (puente/túnel).',
  'Ancho máximo de la calzada en metros.',
  'Distancia entre ejes del camión.',
  'B',
  'La señal SR-28 limita el gálibo o altura de los vehículos para evitar impactos violentos contra el techo de túneles, puentes peatones o cables de alta tensión.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-28',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-28.png'
),

-- 68. [SEÑALIZACIÓN - GENERAL] Señal Preventiva de Resalto o Reductor de Velocidad
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué condición sobre la vía advierte la señal preventiva de código SP-25 (con una elevación en la silueta)?',
  'Un hueco o bache en el asfalto.',
  'La proximidad de un reductor de velocidad tipo resalto (repartidor o policía acostado).',
  'El inicio de una pendiente en bajada.',
  'Una zona de derrumbes sobre la banca.',
  'B',
  'La señal SP-25 notifica la presencia de una deformación física sobre el pavimento instalada para obligar a los vehículos a reducir la marcha.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señal SP-25',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-25.png'
),

-- 69. [A2] Uso del Freno Trasero en Suelo Húmedo
(
  array['A2'],
  'safe_mobility',
  '¿Por qué se debe incrementar la sensibilidad y suavidad sobre el freno trasero de la motocicleta al conducir sobre pavimento mojado?',
  'Porque el pedal se rompe si se presiona fuerte.',
  'Porque la pérdida de tracción trasera por bloqueo hace que la cola de la moto derrape lateralmente (coleo), perdiendo la línea de marcha.',
  'Porque el agua lubrica los discos y no deja frenar.',
  'Porque se apaga la luz de freno trasera.',
  'B',
  'El bloqueo de la rueda trasera en mojado elimina la estabilidad direccional del vehículo de dos ruedas, produciendo un "coleo" difícil de controlar para el piloto.',
  'Guía de Conducción en Condiciones Adversas',
  'Conducción con Lluvia',
  'ANSV',
  '/assets/images/illustrations/a2_derrape_trasero.png'
),

-- 70. [GENERAL] Vías de Un Solo Sentido y Giros
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al circular por una calzada de un solo sentido con tres carriles, ¿desde cuál carril se debe efectuar correctamente un giro a la izquierda?',
  'Desde el carril derecho cruzando transversalmente los demás.',
  'Únicamente desde el carril extremo izquierdo, señalizando con la direccional con antelación.',
  'Desde el carril central acelerando a fondo.',
  'Desde cualquier carril siempre que no vengan otros carros.',
  'B',
  'Para realizar giros de forma segura en vías de varios carriles, el vehículo debe posicionarse anticipadamente en el carril contiguo hacia donde va a realizar la maniobra.',
  'Código Nacional de Tránsito',
  'Artículo 67',
  'Ley 769 de 2002',
  '/assets/images/illustrations/posicion_giro_izquierda.png'
);

-- =============================================================================
-- BANCO DE PREGUNTAS MOTORLAND - BLOQUE 4 (71 - 100)
-- ESTRUCTURA ACTUALIZADA CON COLUMNA 'category' Y NORMATIVA VIGENTE
-- =============================================================================

INSERT INTO public.exam_questions 
(category, module, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, legal_source, legal_article, legal_reference, image_url)
VALUES

-- 71. [GENERAL] Límite de Velocidad en Zonas Escolares y Residenciales (Ley 2251)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Según la Ley 2251 de 2022, ¿cuál es el límite máximo de velocidad permitido para cualquier tipo de vehículo al transitar por zonas escolares, residenciales o de concentración peatonal?',
  '50 km/h.',
  '30 km/h.',
  '20 km/h.',
  '40 km/h.',
  'B',
  'La Ley Julián Esteban (Ley 2251 de 2022) fijó un límite máximo e infranqueable de 30 km/h en zonas urbanas de alta presencia peatonal, como colegios, hospitales y barrios residenciales.',
  'Ley Julián Esteban',
  'Artículo 106 (Modificado)',
  'Ley 2251 de 2022 / Ley 769 de 2002',
  '/assets/images/signals/SR-30_30.png'
),

-- 72. [A2] Horario Obligatorio para Prendas Reflectivas en Motocicletas
(
  array['A2'],
  'traffic_rules',
  'De acuerdo con el Código Nacional de Tránsito, ¿en qué horario deben usar obligatoriamente chaleco o prenda reflectiva tanto el conductor de motocicleta como su acompañante?',
  'Únicamente cuando esté lloviendo.',
  'Desde las 18:00 horas (6:00 p.m.) hasta las 06:00 horas (6:00 a.m.) del día siguiente, y siempre que la visibilidad sea escasa.',
  'Solo cuando transiten por carreteras nacionales.',
  'De 12:00 a.m. a 4:00 a.m. únicamente.',
  'B',
  'El Artículo 94 de la Ley 769 de 2002 exige el uso de prendas reflectivas visibles en horario nocturno (18:00 a 06:00 horas) o en condiciones adversas de visibilidad.',
  'Código Nacional de Tránsito',
  'Artículo 94',
  'Ley 769 de 2002',
  '/assets/images/illustrations/a2_chaleco_reflectivo_horario.png'
),

-- 73. [A2] Reparto Eficiente de Frenado en Motocicleta
(
  array['A2'],
  'safe_mobility',
  'En condiciones normales de pavimento seco, ¿cuál es la proporción recomendada de distribución de fuerza de frenado entre la rueda delantera y la trasera?',
  '100% freno trasero para no irse de cabeza.',
  'Aproximadamente 70% en el freno delantero y 30% en el freno trasero.',
  '50% freno delantero y 50% freno de mano.',
  '100% freno delantero sin tocar el trasero.',
  'B',
  'Al frenar, la transferencia de peso hacia el eje delantero otorga mayor adherencia a la rueda frontal, permitiéndole aportar cerca del 70% de la capacidad total de detención.',
  'Guía de Movilidad Segura para Motociclistas',
  'Técnicas de Frenado Eficiente',
  'ANSV',
  '/assets/images/illustrations/a2_distribucion_frenado.png'
),

-- 74. [B1] Uso de Cintas Reflectivas en Vehículos (Resolución 20223040045295)
(
  array['B1'],
  'vehicle',
  '¿Cuál es el color y posición normativa de las cintas retrorreflectivas requeridas en la parte posterior de los vehículos automotores obligados a llevarlas?',
  'Blanco en la parte trasera y rojo en los lados.',
  'Rojo o blanco/rojo en la parte posterior, y blanco o amarillo en los costados laterales.',
  'Verde fluorescente en todo el contorno.',
  'Azul brillante únicamente.',
  'B',
  'La reglamentación de señalización e identificación de vehículos exige cintas reflectivas rojas o combinadas blanco/rojo en la saga posterior para garantizar visibilidad nocturna a distancia.',
  'Manual de Señalización Vial / Reglamentación Vehicular',
  'Sección Cintas Retrorreflectivas',
  'Resolución 20223040045295 de 2022',
  '/assets/images/illustrations/b1_cintas_reflectivas.png'
),

-- 75. [B1] Reacción ante Aquaplaning (Hidroplaneo)
(
  array['B1'],
  'safe_mobility',
  'Si al transitar en un automóvil sobre charcos o lluvia intensa siente que la dirección pierde firmeza y el vehículo "flota" (aquaplaning), ¿qué acción debe tomar?',
  'Pisar fuertemente el freno y girar el volante con rapidez.',
  'Mantener la dirección firme, no frenar ni acelerar bruscamente y desacelerar progresivamente soltando el pedal del acelerador hasta recuperar agarre.',
  'Halar el freno de mano inmediatamente.',
  'Apagar las luces del carro.',
  'B',
  'El aquaplaning ocurre cuando la llanta no desaloja el agua y pierde contacto con el asfalto. Frenar o girar bruscamente en ese instante provoca la pérdida total de control.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Conducción en Superficies Deslizantes',
  'ANSV',
  '/assets/images/illustrations/b1_aquaplaning_reaccion.png'
),

-- 76. [C1] Documento FUEC para Transporte Especial
(
  array['C1'],
  'traffic_rules',
  '¿Qué significa la sigla FUEC y para qué tipo de servicio público C1 es exigible de forma obligatoria durante cada recorrido?',
  'Fórmula Única de Evaluación del Conductor / Servicio Individual Taxis.',
  'Formulario Único de Extracto del Contrato / Servicio Público de Transporte Especial.',
  'Ficha Única de Estado del Camión / Transporte de Carga.',
  'Factura Única de Embargo del Vehículo / Servicio Urbano.',
  'B',
  'El FUEC es el documento expedido por la empresa de Transporte Especial que ampara el viaje de grupos específicos (estudiantes, turistas, asalariados) bajo un contrato formal.',
  'Estatuto Nacional de Transporte',
  'Decreto 1079 de 2015',
  'Ministerio de Transporte',
  '/assets/images/illustrations/c1_documento_fuec.png'
),

-- 77. [C1] Prelación de Paso en Intersecciones no Señalizadas
(
  array['C1'],
  'traffic_rules',
  'Cuando dos vehículos llegan simultáneamente a una intersección en ángulo recto sin ningún tipo de señal ni semáforo, ¿quién tiene la prelación de paso?',
  'El vehículo de mayor tamaño.',
  'El vehículo que se encuentra a la derecha del otro.',
  'El vehículo que pita primero.',
  'El vehículo que va más rápido.',
  'B',
  'El Artículo 70 del Código Nacional de Tránsito establece que en intersecciones no señalizadas, la preferencia de paso la tiene el vehículo que se aproxima por el lado derecho.',
  'Código Nacional de Tránsito',
  'Artículo 70',
  'Ley 769 de 2002',
  '/assets/images/illustrations/prelacion_interseccion_derecha.png'
),

-- 78. [SEÑALIZACIÓN - GENERAL] Señal Reglamentaria de Prohibido Parquear y Detenerse
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué diferencia existe entre la señal SR-28 de una sola franja diagonal roja sobre fondo azul (Prohibido Parquear) y la señal con una "X" roja sobre fondo azul (SR-28A)?',
  'No hay diferencia, ambas significan lo mismo.',
  'La de una sola franja prohíbe estacionar; la que tiene la "X" prohíbe tanto estacionar como detenerse momentáneamente por cualquier motivo.',
  'La "X" autoriza el parqueo de camiones únicamente.',
  'La franja simple aplica solo para motocicletas.',
  'B',
  'La señal de "Prohibido Parquear y Detenerse" (con X) es más restrictiva: impide realizar cualquier parada, incluso para el ascenso o descenso rápido de pasajeros.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales SR-28 y SR-28A',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-28A_x_roja.png'
),

-- 79. [SEÑALIZACIÓN - GENERAL] Señal Preventiva de Zona Escolar
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué advierte la señal preventiva amarilla con la silueta de dos niños caminando con bultos o morrales (SP-47)?',
  'Proximidad de un parque de atracciones.',
  'Proximidad de una zona escolar o cruce frecuente de estudiantes, obligando a reducir la velocidad a un máximo de 30 km/h.',
  'Obligación de detener el carro y esperar a los estudiantes.',
  'Zona habilitada para ventas ambulantes.',
  'B',
  'La señal SP-47 alerta sobre la cercanía a centros educativos donde la presencia imprevista de menores en la calzada requiere extremar precauciones.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señal SP-47',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-47.png'
),

-- 80. [A2] Conducción con Pasajero (Parrillero)
(
  array['A2'],
  'safe_mobility',
  '¿Cómo afecta el peso adicional de un acompañante (parrillero) en la respuesta dinámica de la motocicleta?',
  'Mejora el frenado y reduce la distancia de detención.',
  'Aumenta la distancia de frenado, altera el centro de gravedad y exige mayor espacio e inclinación para girar.',
  'Hace que la motocicleta consuma menos energía.',
  'No genera ninguna diferencia en la conducción.',
  'B',
  'El peso extra incrementa la inercia del conjunto, lo que alarga los metros necesarios para frenar por completo y modifica el comportamiento del chasis en curvas.',
  'Guía de Movilidad Segura para Motociclistas',
  'Conducción con Acompañante',
  'ANSV',
  '/assets/images/illustrations/a2_pasajero_efecto_frenado.png'
),

-- 81. [A2] Circulación por Carriles Exclusivos (Metro / TransMilenio)
(
  array['A2'],
  'traffic_rules',
  '¿Tienen permitido los motociclistas transitar por los carriles exclusivos de sistemas de transporte masivo (BRT) para adelantar trancones?',
  'Sí, en horas pico.',
  'No, está prohibido de forma tajante e incurre en infracción D.05 (Inmovilización del vehículo).',
  'Sí, si transitan a menos de 30 km/h.',
  'Solo los domingos y festivos.',
  'B',
  'Los carriles BRT o metroplús son de uso exclusivo para la operación de buses masivos. Invadirlos es una infracción de alta peligrosidad sujeto a comparendo e inmovilización.',
  'Código Nacional de Tránsito',
  'Artículo 131 Infracción D.05',
  'Ley 769 de 2002',
  '/assets/images/signals/prohibicion_carril_exclusivo.png'
),

-- 82. [B1] Uso del Cinturón de Seguridad de Tres Puntos
(
  array['B1'],
  'safe_mobility',
  '¿Cuál es la posición correcta de la cinta superior (torácica) del cinturón de seguridad en el cuerpo del ocupante?',
  'Pasando por debajo del brazo o por detrás de la espalda.',
  'Cruzando oblicuamente sobre el centro del pecho y la clavícula, nunca sobre el cuello ni el brazo.',
  'Ajustada directamente sobre la garganta.',
  'Completamente floja para no incomodar.',
  'B',
  'El cinturón debe apoyarse en las estructuras óseas fuertes del cuerpo (clavícula y pelvis). Si se ubica sobre el cuello o abdomen blando, puede causar lesiones internas graves en un choque.',
  'Manual de Referencia para la Conducción de Vehículos',
  'Sistemas de Seguridad Pasiva',
  'ANSV',
  '/assets/images/illustrations/b1_cinturon_posicion_correcta.png'
),

-- 83. [B1] Conducción bajo Niebla Densa
(
  array['B1'],
  'safe_mobility',
  'Al encontrarse con un tramo de carretera cubierto por niebla densa, ¿por qué NO se deben encender las luces altas (plenas)?',
  'Porque descargan la batería del carro más rápido.',
  'Porque el haz de luz alta rebota contra las gotas de agua en suspensión, creando un "muro blanco" reflectivo que enceguece al propio conductor.',
  'Porque las luces altas están prohibidas en carretera.',
  'Porque activan el limpiaparabrisas automáticamente.',
  'B',
  'Las luces altas se proyectan en paralelo a la carretera e impactan de frente la niebla, generando deslumbramiento por reflexión. Se deben usar luces bajas y exploradoras.',
  'Manual de Conducción Preventiva',
  'Condiciones Atmosféricas Adversas',
  'ANSV',
  '/assets/images/illustrations/b1_luces_niebla_efecto.png'
),

-- 84. [C1] Kit o Equipo de Carretera Obligatorio
(
  array['C1'],
  'vehicle',
  '¿Cuál de los siguientes elementos forma parte del equipo de carretera obligatorio que debe portar todo vehículo C1 según el Artículo 30 de la Ley 769 de 2002?',
  'Un televisor portátil.',
  'Un gato con capacidad para elevar el vehículo, cruceta, dos señales de peligro (triángulos/conos), botiquín de primeros auxilios y extintor vigente.',
  'Un juego de llantas de repuesto extra (dos llantas).',
  'Un extintor de agua a presión.',
  'B',
  'El Artículo 30 exige elementos mínimos de auto-rescate, primeros auxilios, herramientas de cambio de rueda y señalización de emergencia para atender imprevistos en carretera.',
  'Código Nacional de Tránsito',
  'Artículo 30',
  'Ley 769 de 2002',
  '/assets/images/illustrations/equipo_carretera_completo.png'
),

-- 85. [C1] Puertas del Vehículo durante la Marcha
(
  array['C1'],
  'traffic_rules',
  '¿Qué infracción comete el conductor de un colectivo o microbús de servicio público que transita con las puertas abiertas mientras lleva pasajeros?',
  'Ninguna, si hace calor.',
  'Comete infracción a las normas de tránsito por poner en riesgo inminente la integridad de los pasajeros ante caídas a la calzada.',
  'Solo es falta si va a más de 80 km/h.',
  'Una falta menor que no genera comparendo.',
  'B',
  'Llevar las puertas abiertas durante el recorrido expone a los usuarios a caer a la vía en giros o frenadas bruscas, constituyendo una grave violación a la seguridad del pasaje.',
  'Código Nacional de Tránsito',
  'Artículo 91 y 131 (Infracción C.22)',
  'Ley 769 de 2002',
  NULL
),

-- 86. [SEÑALIZACIÓN - GENERAL] Señal Informativa de Ruta Nacional
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué significado tiene una señal vertical con forma de escudo blanco y borde negro que contiene un número (ejemplo: 45)?',
  'El límite de velocidad de la curva.',
  'La identificación numerada de la Ruta Nacional por la cual se está transitando.',
  'La distancia en kilómetros a la próxima estación de policía.',
  'El peso máximo del camión.',
  'B',
  'Las señales de escudo identitarias de ruta notifican la codificación oficial de la carretera dentro del sistema vial nacional (como la Ruta 45 o Troncal del Magdalena).',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales de Ruta',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SI_escudo_ruta_45.png'
),

-- 87. [SEÑALIZACIÓN - GENERAL] Demarcación de Línea Amarilla Continua Doble
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica la presencia de una doble línea amarilla continua pintada en el centro de una calzada de doble sentido?',
  'Que ambos sentidos pueden adelantar libremente.',
  'La prohibición estricta de adelantar o cruzar sobre la línea para ambos sentidos de circulación.',
  'Zonas autorizadas para parquear a ambos lados.',
  'Que la vía cambiará a un solo sentido en 100 metros.',
  'B',
  'La doble línea amarilla continua actúa como un muro infranqueable: ningún vehículo de ningún sentido de flujo puede adelantar o invadir el carril contrario.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Demarcaciones Viales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_doble_linea_amarilla.png'
),

-- 88. [A2] Uso de Elementos Reflectivos en las Llantas/Ruedas
(
  array['A2'],
  'safe_mobility',
  '¿Qué utilidad práctica aportan las cintas o stickers reflectivos instalados en los rines de una motocicleta?',
  'Aumentan la velocidad máxima en un 5%.',
  'Permiten que la motocicleta sea vista lateralmente por otros conductores en cruces o intersecciones oscuras.',
  'Evitan pinchazos en el neumático.',
  'Protegen los frenos del barro.',
  'B',
  'La visibilidad lateral de las motocicletas es una de sus mayores deficiencias nocturnas. La reflectividad en los rines alerta a los carros que se aproximan transversalmente.',
  'Guía de Equipamiento e Iluminación Preventiva',
  'Visibilidad Lateral',
  'ANSV',
  '/assets/images/illustrations/a2_rines_reflectivos.png'
),

-- 89. [A2] Conducción con Lluvia y Visibilidad del Casco
(
  array['A2'],
  'safe_mobility',
  'Cuando la lluvia empaña la cara interna del visor del casco, ¿cuál es el dispositivo o accesorio homologado más efectivo para evitar este fenómeno sin abrir el visor?',
  'Limpiar el visor por dentro con la mano mientras se maneja.',
  'La lámina antiempañante (Pinlock) instalada en los pines internos de la mica del casco.',
  'Aplicar aceite de cocina por dentro.',
  'Quitarse el casco mientras escampa.',
  'B',
  'La lámina Pinlock crea una cámara de aire sellada de doble pared que iguala la temperatura e impide la condensación del aliento sobre el visor transparente.',
  'Reglamento Técnico de Cascos',
  'Accesorios de Visibilidad',
  'Resolución 1080 de 2019',
  '/assets/images/illustrations/a2_pinlock_antiempanante.png'
),

-- 90. [B1] Luces Bajas Obligatorias en Carretera
(
  array['B1'],
  'traffic_rules',
  'De acuerdo con la legislación colombiana (Ley 769 de 2002), ¿cuándo es obligatorio transitar con las luces bajas encendidas en carreteras nacionales o departamentales?',
  'Únicamente de noche.',
  'Las 24 horas del día, tanto de día como de noche, en todo el territorio nacional fuera del perímetro urbano.',
  'Solo cuando haya controles policiales.',
  'De 6:00 p.m. a 10:00 p.m.',
  'B',
  'El Artículo 86 de la Ley 769 de 2002 ordena el uso permanente de luces bajas al circular por carreteras fuera de los cascos urbanos para elevar el contraste visual de los carros.',
  'Código Nacional de Tránsito',
  'Artículo 86',
  'Ley 769 de 2002',
  NULL
),

-- 91. [B1] Estado Físico del Conductor y Cansancio
(
  array['B1'],
  'attitudes',
  '¿Cuál es el efecto del cansancio o fatiga extrema en la capacidad de reacción de un conductor de automóvil?',
  'Mejora los reflejos y la concentración.',
  'Disminuye la capacidad de alerta, estrecha el campo visual y alarga significativamente el tiempo de reacción ante un peligro.',
  'No afecta en absoluto si se toma café.',
  'Permite conducir más rápido y seguro.',
  'B',
  'La fatiga disminuye la actividad cerebral, causando la pérdida de percepción del entorno y micro-sueños letales de pocos segundos al volante.',
  'Manual de Conducción Preventiva',
  'Factores Humanos en la Conducción',
  'ANSV',
  '/assets/images/illustrations/fatiga_conductor_reaccion.png'
),

-- 92. [C1] Transporte de Carga Sobresaliente en Microbuses
(
  array['C1'],
  'traffic_rules',
  '¿Está permitido llevar bultos, equipajes o cargas que sobresalgan por los laterales o ventanas de un vehículo de servicio público C1?',
  'Sí, si van amarrados con lazos gruesos.',
  'No, ninguna carga o equipaje puede sobresalir de la carrocería ni impedir la visibilidad del conductor o el movimiento seguro.',
  'Sí, siempre que no tapen los espejos.',
  'Solo en rutas veredales o rurales.',
  'B',
  'Toda carga debe ir debidamente asegurada en los compartimentos o bodegas destinados para tal fin, sin alterar las dimensiones ni la estabilidad del automotor.',
  'Código Nacional de Tránsito',
  'Artículo 102',
  'Ley 769 de 2002',
  NULL
),

-- 93. [C1] Plan Estratégico de Seguridad Vial (PESV)
(
  array['C1'],
  'traffic_rules',
  '¿Qué empresas o entidades están obligadas a diseñar e implementar un Plan Estratégico de Seguridad Vial (PESV) según la Ley 2050 de 2020 y Resoluciones del Ministerio de Transporte?',
  'Únicamente las escuelas de automovilismo.',
  'Toda entidad, organización o empresa del sector público o privado que posea, fabrique, ensamble, comercialice, contrate o administre flotas de más de 10 vehículos o contrate conductores.',
  'Solo las empresas de aviación comercial.',
  'Las empresas con más de 1.000 empleados.',
  'B',
  'El PESV es la herramienta de gestión preventiva obligatoria para todas las organizaciones que operen flotas vehiculares o personal de conducción en Colombia.',
  'Ley de Planes Estratégicos de Seguridad Vial',
  'Artículo 1 y 2',
  'Ley 2050 de 2020 / Res. 20223040040595 de 2022',
  '/assets/images/illustrations/c1_pesv_empresa.png'
),

-- 94. [SEÑALIZACIÓN - GENERAL] Señal Preventiva de Reducción de Calzada
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica la señal preventiva de código SP-13 (líneas que se estrechan en un costado)?',
  'Un aumento en el número de carriles disponibles.',
  'La reducción del ancho de la calzada por el costado señalado, requiriendo reubicarse en el carril libre.',
  'El ingreso a una zona de parqueo obligatorio.',
  'La presencia de un puente peatonal elevado.',
  'B',
  'La señal SP-13 previene al conductor sobre la pérdida de un carril o el angostamiento de la calzada para realizar la incorporación con la debida antelación.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señal SP-13',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-13.png'
),

-- 95. [SEÑALIZACIÓN - GENERAL] Demarcación de Borde de Calzada (Línea Blanca Continua)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué función cumple la línea continua blanca demarcada longitudinalmente en el extremo derecho de una carretera (Línea de Berma)?',
  'Indica el carril exclusivo para motocicletas.',
  'Delimita el límite exterior de la calzada rodable, separando el carril de circulación de la berma o zona de parqueo de emergencia.',
  'Es una zona para realizar adelantamientos rápidos por la derecha.',
  'Señala la velocidad máxima del tramo.',
  'B',
  'La línea de borde de calzada guíal la trayectoria nocturna y delimita el área segura de rodadura, advirtiendo el inicio de la berma no transitable.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Demarcaciones Viales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_linea_berma.png'
),

-- 96. [A2] Técnica de Subida de Bordillos o Obstáculos Pequeños
(
  array['A2'],
  'safe_mobility',
  'Si en una maniobra inevitable a baja velocidad debe sobrepasar un pequeño obstáculo o resalto con la motocicleta, ¿cuál es la postura corporal adecuada?',
  'Inclinarse completamente hacia adelante y apretar el freno delantero.',
  'Ponerse levemente de pie sobre los posapiés, flexionar rodillas y codos, y mantener la aceleración constante sin frenar de golpe.',
  'Sentarse hacia atrás y soltar el manubrio.',
  'Apagar el motor inmediatamente.',
  'B',
  'Levantarse ligeramente de la silla transforma las piernas en amortiguadores adicionales, evitando que el impacto desestabilice la columna del piloto o el chasis.',
  'Guía de Conducción Técnica y Preventiva',
  'Superación de Obstáculos',
  'ANSV',
  '/assets/images/illustrations/a2_postura_posapies_obstaculo.png'
),

-- 97. [B1] Presión de Aire en Neumáticos y Ahorro de Combustible
(
  array['B1'],
  'vehicle',
  '¿Qué consecuencia tiene circular de forma continua con los neumáticos por debajo de la presión de inflado recomendada por el fabricante?',
  'Se reduce el consumo de gasolina y frena mejor.',
  'Aumenta el desgaste prematuro en los bordes de la banda de rodamiento, incrementa el consumo de combustible y eleva el riesgo de reventón por sobrecalentamiento.',
  'Mejora la velocidad máxima del automóvil.',
  'No produce ningún efecto adverso.',
  'B',
  'La baja presión genera mayor fricción y deformación de la carcasa de la llanta, lo que obliga al motor a hacer más esfuerzo (gastando más combustible) y degrada los hombros de la goma.',
  'Manual de Mecánica Básica y Mantenimiento',
  'Cuidado de Neumáticos',
  'ANSV',
  '/assets/images/illustrations/b1_presion_llantas_deformacion.png'
),

-- 98. [C1] Planilla de Viaje Ocasional
(
  array['C1'],
  'traffic_rules',
  '¿Cuándo debe portar un vehículo de servicio público C1 (ejemplo: taxi o colectivo urbano) la Planilla de Viaje Ocasional?',
  'Cuando transita dentro de su ruta urbana asignada.',
  'Cuando realiza un servicio fuera de su zona urbana de operación autorizada (salida intermunicipal o departamental).',
  'Únicamente cuando va a revisión técnica.',
  'Solo cuando transporta animales domésticos.',
  'B',
  'La Planilla de Viaje Ocasional autoriza excepcionalmente a un vehículo de transporte urbano a salir de su jurisdicción para prestar un servicio especial fuera de la ciudad.',
  'Estatuto Nacional de Transporte',
  'Decreto 1079 de 2015',
  'Ministerio de Transporte',
  '/assets/images/illustrations/c1_planilla_viaje_ocasional.png'
),

-- 99. [SEÑALIZACIÓN - GENERAL] Señal Preventiva de Pendiente Pronunciada
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué precaución exige la señal preventiva con la silueta de un camión descendiendo por una inclinación (SP-26)?',
  'Acelerar para aprovechar el impulso de la Bajada.',
  'Engranar un cambio bajo en la caja de velocidades para frenar con el motor y evitar el sobrecalentamiento de los frenos de servicio.',
  'Apagar el motor para ahorrar combustible durante el descenso.',
  'Colocar la palanca en neutro.',
  'B',
  'Ante descendimientos pronunciados, se debe utilizar la compresión del motor (freno de motor) para mantener el control sin fatigar o hervir el líquido de frenos.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Señal SP-26',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-26.png'
),

-- 100. [GENERAL] Uso de Dispositivos Móviles al Conducir
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Bajo qué única circunstancia está permitido hablar por teléfono celular o manipular pantallas mientras se conduce un vehículo en marcha?',
  'Cuando se transita a menos de 20 km/h.',
  'Mediante el uso de sistemas de manos libres o accesorios que no exijan sostener el dispositivo con las manos ni distraigan la atención visual de la vía.',
  'Si se sostiene con un solo hombro contra la oreja.',
  'Durante la noche cuando hay menos tráfico.',
  'B',
  'El Artículo 131 (Infracción C.38) sanciona sostener o manipular dispositivos de comunicación al conducir. Solo se permite el uso hands-free que mantenga ambas manos en el volante/manubrio.',
  'Código Nacional de Tránsito',
  'Artículo 131 Infracción C.38',
  'Ley 769 de 2002',
  '/assets/images/illustrations/manos_libres_conduccion.png'
),

-- 101. [GENERAL] Distancia de Frenado y Reacción
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Qué componentes integran la distancia total de detención de un vehículo en marcha?',
  'La distancia de aceleración sumada a la distancia de parqueo.',
  'La distancia de reacción (tiempo en percibir y accionar) sumada a la distancia de frenado mecánico.',
  'La longitud total del vehículo multiplicada por la velocidad actual.',
  'La distancia entre ejes sumada a la berma de seguridad.',
  'B',
  'La distancia total de detención contempla los metros recorridos durante el tiempo de reacción del conductor más los metros que tarda el sistema de frenos en detener el vehículo por completo.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Conducción Preventiva',
  'ANSV 2026',
  NULL
),

-- 102. [GENERAL] Pérdida de Adherencia por Lluvia
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Qué fenómeno se produce cuando una capa de agua se acumula entre la calzada y las llantas haciendo perder el contacto directo con el suelo?',
  'Sobrecalentamiento del motor.',
  'Hidroplaneo o aquaplaning.',
  'Bloqueo automático de la dirección.',
  'Desgaste prematuro de los discos de freno.',
  'B',
  'El hidroplaneo ocurre cuando las llantas no alcanzan a evacuar el agua de la calzada a través de sus ranuras, perdiendo completamente la tracción y el control direccional.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Factores Climáticos y Riesgos',
  'ANSV 2026',
  NULL
),

-- 103. [GENERAL] Prioridad en Intersecciones Sin Señalizar
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'En una intersección sin semáforo ni señalización de prioridad, ¿quién tiene la prelación de paso?',
  'El vehículo que circula a mayor velocidad.',
  'El vehículo que se aproxima por el lado derecho.',
  'El vehículo de mayor tamaño o pesaje.',
  'El vehículo que realice el giro a la izquierda.',
  'B',
  'A falta de señalización expresa o autoridad de tránsito en un cruce de vías de igual jerarquía, la prelación la tiene el vehículo que ingresa o se aproxima por la derecha.',
  'Código Nacional de Tránsito',
  'Artículo 70 - Prelación en Intersecciones',
  'Ley 769 de 2002',
  NULL
),

-- 104. [GENERAL] Señal Reglamentaria de Detención Obligatoria
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué orden o restricción establece la señal octagonal de fondo rojo (SR-01)?',
  'Disminuir la velocidad únicamente si vienen peatones.',
  'Detener completamente el vehículo antes de la línea de demarcación o intersección.',
  'Ceder el paso acelerando rápidamente.',
  'Girar obligatoriamente a la derecha.',
  'B',
  'La señal reglamentaria de PARE (SR-01) exige la detención total del vehículo. Avanzar sin detenerse por completo constituye una infracción gravísima al tránsito.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-01',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-01.png'
),

-- 105. [GENERAL] Uso Obligatorio de Luces
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿En qué horario o circunstancia es obligatorio el uso de luces medias para vehículos automotores de cuatro o más ruedas en vías urbanas y carreteras?',
  'Solo cuando se transita en autopistas de alta velocidad.',
  'Entre las 18:00 horas y las 06:00 horas del día siguiente, o cuando las condiciones de visibilidad sean adversas.',
  'Únicamente entre la medianoche y las 04:00 horas.',
  'Exclusivamente en túneles superiores a 500 metros.',
  'B',
  'El Código Nacional de Tránsito exige encender la iluminación media desde las 6:00 p.m. hasta las 6:00 a.m. y en cualquier momento donde la lluvia, niebla o penumbra reduzcan la visibilidad.',
  'Código Nacional de Tránsito',
  'Artículo 86 - Permiso y Uso de Luces',
  'Ley 769 de 2002',
  NULL
),

-- 106. [GENERAL] Función de la Seguridad Pasiva
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál es el objetivo principal de los elementos de seguridad pasiva en un vehículo (ej. cinturón, cintas reflexivas, airbags)?',
  'Evitar que ocurra el siniestro o la colisión vial.',
  'Minimizar la gravedad de las lesiones o secuelas en los ocupantes una vez que el impacto ya ha ocurrido.',
  'Aumentar la potencia y respuesta de aceleración en carreteras.',
  'Reemplazar la inspección mecánica preoperacional.',
  'B',
  'A diferencia de la seguridad activa (que previene el choque), la seguridad pasiva actúa durante y después de la colisión para proteger la integridad física de las personas.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistemas del Vehículo',
  'ANSV 2026',
  NULL
),

-- 107. [MOTO] Técnica Adecuada de Frenado
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Al efectuar una frenada en motocicleta bajo condiciones normales, ¿cuál es la distribución recomendada del uso de los frenos?',
  'Usar un 100% el freno trasero para evitar perder la estabilidad.',
  'Dosificar el freno delantero como principal (aprox. 70%) y acompañar suavemente con el freno trasero (aprox. 30%).',
  'Utilizar únicamente el freno de mano o manigueta.',
  'Bloquear intencionalmente la rueda trasera para derrapar.',
  'B',
  'Al frenar, la transferencia de peso se desplaza hacia la rueda delantera, otorgándole mayor adherencia y capacidad de detención, mientras que el freno trasero actúa como estabilizador.',
  'Manual de Referencia ANSV',
  'Módulo 5 - Conducción de Motocicletas',
  'ANSV 2026',
  '/assets/images/illustrations/frenado_motocicleta.png'
),

-- 108. [GENERAL] Demarcaciones sobre la Calzada
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica una doble línea continua de color amarillo pintada en el centro de una vía bidireccional?',
  'Que ambos sentidos pueden adelantar si no vienen vehículos.',
  'Prohibición severa de adelantar o invadir el carril contrario para los conductores en ambos sentidos.',
  'Paso exclusivo para vehículos pesados o de transporte público.',
  'Zona habilitada para parqueo en la berma.',
  'B',
  'La doble línea amarilla continua actúa como una barrera invisible. Delimita los sentidos de circulación e indica que está prohibido adelantar en ambas direcciones.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Demarcaciones Longitudinales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/demarcacion_doble_continua.png'
),

-- 109. [GENERAL] Distancia Mínima al Adelantar Ciclistas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al realizar la maniobra de adelantamiento a un ciclista en la vía pública, ¿qué separación lateral mínima debe mantener el conductor?',
  '0.5 metros.',
  '1.5 metros.',
  '2.5 metros.',
  '3.0 metros.',
  'B',
  'Para prevenir el "efecto succión" y dar margen de maniobra ante caídas del ciclista, la ley exige mantener como mínimo 1.5 metros de distancia lateral al adelantarlo.',
  'Código Nacional de Tránsito y Ley ProBici',
  'Artículo 60 - Distancia al Adelantar',
  'Ley 1811 de 2016',
  '/assets/images/illustrations/distancia_lateral_ciclista.png'
),

-- 110. [GENERAL] Diagnóstico de Neumáticos por Desgaste
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'Si al revisar la banda de rodadura de una llanta se observa un desgaste excesivo únicamente en el centro de la pista, ¿cuál es la causa principal?',
  'Rodar el neumático con presión de aire inferior a la recomendada.',
  'Rodar el neumático con exceso de presión de aire respecto a la recomendada por el fabricante.',
  'Fallas graves en la alineación del tren delantero.',
  'Uso prolongado sobre pavimento mojado.',
  'B',
  'El exceso de presión hace que la llanta se abombe en el centro, apoyando la mayor parte del peso sobre la banda central de rodamiento y acelerando su desgaste en esa área.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Inspección y Llantas',
  'ANSV 2026',
  NULL
),

-- 111. [GENERAL] Principio Fundamental de Visión Cero
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Según el enfoque internacional de Visión Cero adoptado en la planificación vial, ¿cuál es el pilar ético fundamental sobre los siniestros de tránsito?',
  'Los siniestros son eventos inevitables derivados del progreso automotor.',
  'Ninguna muerte ni lesión grave en el tránsito es aceptable ni inevitable.',
  'La responsabilidad de los accidentes recae exclusivamente en la infraestructura estatal.',
  'Los conductores de vehículos pesados asumen todo el riesgo de la vía.',
  'B',
  'Visión Cero parte de la premisa de que el sistema de movilidad debe diseñarse para proteger la vida humana, reconociendo que los seres humanos cometen errores y que las muertes en las vías son prevenibles.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Principios de Visión Cero',
  'ANSV 2026',
  NULL
),

-- 112. [GENERAL] Protocolo de Emergencias PAS
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'En la cadena de atención a un siniestro vial, ¿qué significan las siglas del protocolo de actuación "PAS"?',
  'Prevenir, Alertar y Salvar.',
  'Proteger, Avisar y Socorrer.',
  'Parar, Auxiliar y Señalizar.',
  'Precaución, Asistencia y Salvamento.',
  'B',
  'El esquema internacional PAS establece el orden estricto de actuación: primero Proteger la zona para evitar nuevos impactos, luego Avisar a los cuerpos de emergencia y finalmente Socorrer a las víctimas.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Primeros Auxilios y Emergencias',
  'ANSV 2026',
  NULL
),

-- 113. [GENERAL] Primera Acción en Fase "Proteger" del PAS
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Al hacer presencia en la escena de un siniestro vial con heridos, ¿cuál debe ser la primera acción a ejecutar en la fase de "Proteger"?',
  'Mover inmediatamente a las víctimas hacia la acera.',
  'Evaluar riesgos latentes (fugas, fuego) y señalizar la zona para evitar otros colisiones.',
  'Dar bebidas calientes a los lesionados para evitar el estado de shock.',
  'Tomar fotografías para los reportes de las aseguradoras.',
  'B',
  'Proteger implica garantizar que el lugar sea seguro tanto para los accidentados como para los socorredores, mediante la señalización con triángulos/conos y apagando motores.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Gestión de Escenarios de Riesgo',
  'ANSV 2026',
  NULL
),

-- 114. [GENERAL] Línea Única de Emergencias Urbanas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'En el territorio colombiano, ¿cuál es el número de marcación gratuita unificado para solicitar auxilio médico o policial ante una emergencia urbana?',
  '123',
  '911',
  '767',
  '112',
  'A',
  'El código telefónico 123 es la Numeralia Única de Seguridad y Emergencias (NUSE) a nivel nacional en zonas urbanas de Colombia.',
  'Código Nacional de Tránsito y Protocolos NUSE',
  'Atención de Emergencias Viales',
  'Decreto 1078 de 2015',
  NULL
),

-- 115. [GENERAL] Línea de Atención en Carreteras Nacionales
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Para reportar un evento, accidente o solicitar asistencia de grúa/ambulancia en carreteras nacionales de Colombia, ¿qué número se marca desde el celular?',
  '#123',
  '#767',
  '#911',
  '#115',
  'B',
  'El canal #767 de la Dirección de Tránsito y Transporte (DITRA) ofrece asistencia, estado de vías y atención de emergencias en la red vial nacional.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Asistencia en Carretera',
  'ANSV 2026',
  NULL
),

-- 116. [GENERAL] Distancia de Seguridad hasta 30 km/h
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'De acuerdo con las guías pedagógicas de seguridad vial, ¿cuál es la distancia de separación mínima recomendada entre vehículos cuando se circula a velocidades de hasta 30 km/h?',
  '5 metros.',
  '10 metros.',
  '20 metros.',
  '15 metros.',
  'B',
  'A velocidades reducidas (hasta 30 km/h), mantener un espacio de al menos 10 metros garantiza el margen necesario para reaccionar ante una frenada intempestiva del vehículo delantero.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Distancias de Seguridad',
  'ANSV 2026',
  NULL
),

-- 117. [GENERAL] Distancia de Seguridad entre 30 y 60 km/h
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Cuando un vehículo transita a una velocidad comprendida entre los 30 km/h y los 60 km/h, ¿qué distancia de separación debe guardar con el vehículo que lo antecede?',
  '10 metros.',
  '20 metros.',
  '30 metros.',
  '15 metros.',
  'B',
  'Para el rango de velocidad de 30 a 60 km/h, la distancia preventiva mínima estipulada para evitar colisiones por alcance es de 20 metros.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Distancias de Seguridad',
  'ANSV 2026',
  NULL
),

-- 118. [GENERAL] Distancia de Seguridad entre 60 y 80 km/h
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'En un rango de velocidad de circulación entre 60 km/h y 80 km/h, ¿cuál es la separación reglamentaria sugerida entre dos vehículos?',
  '15 metros.',
  '20 metros.',
  '25 metros.',
  '35 metros.',
  'C',
  'Al aumentar la velocidad en el rango de 60 a 80 km/h, la energía cinética requerida para la detención se incrementa, exigiendo una brecha espacial de mínimo 25 metros.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Distancias de Seguridad',
  'ANSV 2026',
  NULL
),

-- 119. [GENERAL] Distancia de Seguridad a más de 80 km/h
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'A velocidades iguales o superiores a 80 km/h, ¿qué distancia de separación debe mantenerse respecto al vehículo que marcha adelante?',
  '15 metros.',
  '20 metros.',
  '30 metros o la distancia que determine la autoridad mediante señalización.',
  '50 metros obligatorios sin excepción.',
  'C',
  'Por encima de los 80 km/h se requieren al menos 30 metros de distancia, o ajustarse a la regla del tiempo/señalización fijada por las autoridades para tramos de alta velocidad.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Distancias de Seguridad',
  'ANSV 2026',
  NULL
),

-- 120. [GENERAL] Uso de Luces Altas y Niebla
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Por qué razón técnica está contraindicado el uso de luces altas (de carretera) al conducir en zonas con presencia de niebla densa?',
  'Porque el sistema eléctrico sufre sobrecalentamiento por el esfuerzo.',
  'Porque las microgotas de agua en suspensión reflejan la luz de vuelta hacia el conductor, creando una cortina blanca ciega.',
  'Porque el calor de las luces altas derrite los empaques plásticos de las farolas.',
  'Porque apaga automáticamente las luces de delimitación traseras.',
  'B',
  'Las luces altas chocan directamente contra el haz de humedad reflectiva de la niebla provocando encandilamiento al propio conductor. Se deben emplear luces bajas o exploradoras antiniebla.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Conducción Adversa',
  'ANSV 2026',
  NULL
),

-- 121. [GENERAL] Vientos Laterales Fuertes
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Al enfrentar ráfagas de viento lateral fuerte durante la conducción en carretera o puentes, ¿cuál es la técnica de control correcta?',
  'Incrementar rápidamente la velocidad para atravesar el flujo de aire.',
  'Reducir la velocidad, sujetar con firmeza el volante o manubrio y corregir suavemente la trayectoria.',
  'Poner la caja de cambios en posición neutra o desembragar.',
  'Activar inmediatamente el freno de mano.',
  'B',
  'Las ráfagas laterales desestabilizan la aerodinámica del vehículo. Reducir la velocidad disminuye la fuerza ejercida por el viento y sujetar con firmeza la dirección previene salidas de carril.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Conducción en Condiciones Extremas',
  'ANSV 2026',
  NULL
),

-- 122. [GENERAL] Encendido de Vehículos Modernos y Eficiencia
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Dentro de las pautas de conducción eficiente para vehículos de inyección electrónica modernos, ¿cómo se debe proceder al encender el motor?',
  'Pisar a fondo el acelerador mientras se da arranque.',
  'Girar la llave o presionar el botón de encendido sin acelerar.',
  'Acelerar repetidamente en vacío durante un minuto antes de iniciar la marcha.',
  'Encender con las luces altas accionadas.',
  'B',
  'Los motores modernos con inyección electrónica regulan automáticamente la mezcla de aire y combustible al arrancar; pisar el acelerador malgasta combustible y desgasta el motor en frío.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Conducción Eficiente y Sostenible',
  'ANSV 2026',
  NULL
),

-- 123. [GENERAL] Infracción por Estacionar sobre el Andén
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Está permitido estacionar un vehículo automotor sobre las aceras, andenes o espacios destinados a peatones?',
  'Sí, siempre y cuando no se obstaculice más de la mitad del paso.',
  'No, está expresamente prohibido por la normativa de tránsito.',
  'Sí, únicamente si se dejan encendidas las luces de estacionamiento.',
  'Sí, durante horarios nocturnos de bajo flujo de transeúntes.',
  'B',
  'El espacio público de andenes y aceras es exclusivo para peatones. Ocuparlo con vehículos constituye una infracción sujeta a comparendo y eventual inmovilización.',
  'Código Nacional de Tránsito',
  'Artículo 76 - Lugares Prohibidos para Estacionar',
  'Ley 769 de 2002',
  NULL
),

-- 124. [GENERAL] Estacionamiento Urbano junto al Sardinel
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al estacionar un vehículo en vías urbanas autorizadas, ¿a qué distancia máxima respecto al sardinel o bordillo de la acera debe quedar ubicado?',
  'No más de 0.30 metros (30 cm).',
  'No más de 1.00 metro.',
  'A mínimo 0.50 metros.',
  'A la distancia que determine el conductor según el ancho del carril.',
  'A',
  'La reglamentación especifica que el vehículo debe adosarse paralelamente al sardinel a una distancia no superior a 30 centímetros para no invadir la zona de circulación del carril.',
  'Código Nacional de Tránsito',
  'Artículo 75 - Normas para Estacionar',
  'Ley 769 de 2002',
  NULL
),

-- 125. [GENERAL] Estacionamiento Frente a Hidrantes
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuál es la norma de tránsito sobre estacionar frente a los hidrantes de agua para bomberos?',
  'Se puede estacionar si el conductor permanece dentro del vehículo.',
  'Está totalmente prohibido estacionar frente a hidrantes o zonas de emergencia.',
  'Está permitido si se trata de vehículos particulares únicamente.',
  'Se permite parqueo por un periodo máximo de 15 minutos.',
  'B',
  'Bloquear el acceso a hidrantes priva a los equipos de emergencia del suministro de agua en caso de incendio, siendo un sitio de estacionamiento restringido en todo momento.',
  'Código Nacional de Tránsito',
  'Artículo 76 - Prohibiciones de Estacionamiento',
  'Ley 769 de 2002',
  NULL
),

-- 126. [GENERAL] Estacionamiento en Curvas o Rampas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Es legal parquear un vehículo en curvas, cimas de pendientes o zonas de visibilidad reducida?',
  'Sí, usando los triángulos de señalización a 5 metros.',
  'No, es una infracción de tránsito por generar riesgo alto de colisión.',
  'Sí, únicamente durante las horas del día.',
  'Sí, si la vía cuenta con más de dos carriles por sentido.',
  'B',
  'Estacionar en curvas o pendientes ciegas anula el margen de reacción de otros usuarios de la vía que no pueden divisar el obstáculo con anticipación.',
  'Código Nacional de Tránsito',
  'Artículo 76 - Prohibición en Curvas y Pendientes',
  'Ley 769 de 2002',
  NULL
),

-- 127. [GENERAL] Factor Humano en la Siniestralidad Vial
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'De acuerdo con las estadísticas de siniestralidad de la ANSV, ¿qué porcentaje aproximado de los siniestros viales está asociado directamente al factor humano (comportamiento)?',
  'Cerca del 30%.',
  'Más del 90%.',
  'Exactamente el 50%.',
  'Menos del 15%.',
  'B',
  'Más del noventa por ciento de los siniestros viales tienen como causa raíz fallas humanas, tales como exceso de velocidad, distracción, impericia o consumo de sustancias.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Factores de Riesgo Vial',
  'ANSV 2026',
  NULL
),

-- 128. [GENERAL] Pausas Activas en Conducción Prolongada
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'En viajes de larga distancia o conducción continua por más de 2 horas (o 200 km), ¿cuál es la pausa de descanso mínima aconsejada?',
  '5 minutos sin bajar del vehículo.',
  'Al menos 15 minutos de descanso activo.',
  '30 segundos en un semáforo.',
  'No se requieren pausas si se consume café u organizadores de energía.',
  'B',
  'Realizar descensos de al menos 15 minutos cada 2 horas permite estirar extremidades, oxigenar el cerebro y mitigar los efectos de la fatiga muscular y mental.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Fatiga y Somnolencia',
  'ANSV 2026',
  NULL
),

-- 129. [GENERAL] Efecto Depresor del Alcohol
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Desde el punto de vista psicofísico, ¿cómo clasifican las autoridades de salud y tránsito a las bebidas alcohólicas al actuar en el organismo del conductor?',
  'Estimulantes del sistema nervioso que mejoran los reflejos.',
  'Depresoras del sistema nervioso central que deterioran la coordinación y juicio.',
  'Sustancias neutras que no afectan las habilidades psicomotrices.',
  'Reguladoras de la presión arterial y la visión lejana.',
  'B',
  'El alcohol deprime el sistema nervioso central, reduciendo la velocidad de reacción, mermando el campo visual periférico e induciendo una falsa sensación de confianza.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Alcohol y Conducción',
  'ANSV 2026',
  NULL
),

-- 130. [GENERAL] Política de Alcohol en Conducción en Colombia
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuál es la política legal frente al nivel de alcoholemia permitido para conductores de vehículos en Colombia?',
  'Margen de tolerancia hasta Grado 1 siempre que no causen daños.',
  'Tolerancia Cero (0 mg de etanol/100 ml de sangre total) para sancionar desde el estado de embriaguez más leve.',
  'Permisión de 2 cervezas para vehículos particulares únicamente.',
  'Tolerancia únicamente en vías rurales durante días festivos.',
  'B',
  'La Ley 1696 sanciona penal y administrativamente cualquier grado de alcoholemia detectado en pruebas de aire espirado o sangre en conductores.',
  'Ley de Embriaguez',
  'Sanciones e Infracciones por Alcoholemia',
  'Ley 1696 de 2013',
  NULL
),

-- 131. [GENERAL] Efectos del Consumo de Marihuana
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Cómo altera el consumo de cannabis/marihuana el desempeño psicomotor al conducir un vehículo?',
  'Incrementa el campo visual y acelera la toma de decisiones.',
  'Deteriora la percepción del tiempo, la distancia, la velocidad y la concentración.',
  'Mejora la capacidad de reaccionar ante imprevistos mecánicos.',
  'Elimina el cansancio muscular de manera permanente.',
  'B',
  'El THC afecta la corteza cerebral alterando la noción espacio-temporal y relentizando significativamente las respuestas de frenado o esquive.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Sustancias Psicoactivas',
  'ANSV 2026',
  NULL
),

-- 132. [GENERAL] Medicamentos Antihistamínicos y Conducción
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Qué precaución debe tener un conductor cuando le han formulado medicamentos antihistamínicos (para alergias o gripas)?',
  'Ninguna, al ser fármacos de venta libre no tienen incidencia.',
  'Verificar si producen somnolencia o lentitud de reflejos antes de ponerse al volante.',
  'Duplicar la dosis para contrarrestar el cansancio vial.',
  'Conducir únicamente con las ventanas abiertas.',
  'B',
  'Muchos antihistamínicos de primera generación producen un fuerte efecto sedante y somnolencia comparable a niveles moderados de alcoholemia.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Fármacos y Seguridad Vial',
  'ANSV 2026',
  NULL
),

-- 133. [GENERAL] Relación entre Velocidad y Campo Visual
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿A qué fenómeno de la visión se expone un conductor a medida que incrementa notablemente la velocidad del vehículo?',
  'Aumento de la visión periférica o panorámica.',
  'Efecto túnel o estrechamiento paulatino del campo visual periférico.',
  'Visión nocturna mejorada.',
  'Ceguera al color rojo de los semáforos.',
  'B',
  'El "efecto túnel" reduce la visión lateral: a mayor velocidad, el cerebro enfoca solo el centro lejano y pierde capacidad de detectar peatones u obstáculos a los costados.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Velocidad y Percepción',
  'ANSV 2026',
  NULL
),

-- 134. [GENERAL] Límite de Velocidad en Zonas Residenciales y Escolares
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Salvo que exista una señalización legal que indique un valor inferior, ¿cuál es el límite máximo de velocidad permitido en zonas escolares y residenciales?',
  '50 km/h',
  '30 km/h',
  '60 km/h',
  '20 km/h',
  'B',
  'La Ley 2251 (Ley Julián Esteban) fijó el tope de velocidad en áreas con presencia masiva de niños, peatones o zonas residenciales en un máximo de 30 km/h.',
  'Ley de Velocidades Seguras',
  'Artículo 106 - Límites Urbanos',
  'Ley 2251 de 2022',
  NULL
),

-- 135. [GENERAL] Paso Peatonal Demarcado (Cebra)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'En un paso peatonal o cebra no regulado por semáforo, ¿quién goza de la prelación absoluta de paso?',
  'El vehículo que circula por la vía principal.',
  'El peatón que se dispone a cruzar o ya está sobre la calzada.',
  'El servicio de transporte público colectivo.',
  'El vehículo que encienda primero las luces intermitentes.',
  'B',
  'Los peatones son los actores más vulnerables en el tránsito. En las zonas demarcadas para su cruce, los vehículos están obligados a detenerse para darles paso.',
  'Código Nacional de Tránsito',
  'Artículo 63 - Prelación de Peatones',
  'Ley 769 de 2002',
  '/assets/images/illustrations/paso_peatonal_cebra.png'
),

-- 136. [GENERAL] Peatones con Condiciones Especiales
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al detectar la presencia de un peatón usando bastón blanco/verde, un adulto mayor o un niño cerca a la calzada, ¿cuál es la conducta que debe adoptar el conductor?',
  'Tocar la corneta para que se apresuren en cruzar.',
  'Reducir la velocidad, incrementar la atención y ceder el paso si van a cruzar.',
  'Mantener la velocidad confiando en que se detendrán.',
  'Adelantar por el carril opuesto a gran velocidad.',
  'B',
  'Los adultos mayores, niños y personas con discapacidad requieren especial consideración por sus tiempos de reacción o limitaciones. El conductor preventivo reduce la marcha.',
  'Código Nacional de Tránsito',
  'Artículo 58 - Actores Vulnerables',
  'Ley 769 de 2002',
  NULL
),

-- 137. [GENERAL] Invasión de Infraestructura Ciclistica
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Puede un vehículo automotor particular o motocicleta transitar por una ciclobanda o ciclorruta argumentando que está desierta?',
  'Sí, en horarios nocturnos de baja movilidad.',
  'No, está totalmente prohibido invadir la infraestructura segregada para ciclistas.',
  'Sí, para realizar adelantamientos rápidos por la derecha.',
  'Sí, solo si se desplaza a menos de 20 km/h.',
  'B',
  'La infraestructura ciclista es de uso exclusivo para usuarios de la bicicleta y movilidad activa. Invadirla acarrea sanciones y pone en grave riesgo a los ciclistas.',
  'Ley ProBici y CNT',
  'Protección al Ciclista e Infraestructura',
  'Ley 1811 de 2016',
  NULL
),

-- 138. [GENERAL] Clasificación de Señales Preventivas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es la función principal de la señalización vial preventiva o de advertencia?',
  'Imponer sanciones de tipo económico.',
  'Alertar al usuario sobre la proximidad de un peligro, condición especial o riesgo de la vía.',
  'Informar sobre nombres de municipios y distancias en kilómetros.',
  'Establecer el sentido de giro obligatorio en los cruces.',
  'B',
  'Las señales preventivas (generalmente romboidales amarillas con borde negro) advierten con antelación para que el conductor adapte su velocidad o maniobra con seguridad.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señales Preventivas',
  'Resolución 20223040045295 de 2022',
  NULL
),

-- 139. [GENERAL] Señal Preventiva Curva Peligrosa (SP-01)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué precaución exige la presencia de una señal preventiva con una flecha curvada (SP-01)?',
  'Mantener o aumentar la velocidad para tomar la curva con impulso.',
  'Reducir la velocidad antes de ingresar a la curva para evitar derrapes o invasión de carril contrario.',
  'Detener completamente el vehículo en la mitad del giro.',
  'Accionar el freno de mano al momento de girar el volante.',
  'B',
  'La señal advierte un cambio brusco en la geometría horizontal de la vía. Obliga a adecuar la velocidad antes de entrar al viraje.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SP-01',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-01.png'
),

-- 140. [GENERAL] Señal Reglamentaria Ceda el Paso (SR-02)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué obligación impone la señal reglamentaria con forma de triángulo invertido (SR-02)?',
  'Detención obligatoria sin importar si vienen o no vehículos.',
  'Reducir la velocidad y detenerse si es necesario para ceder la prelación a los vehículos que transitan por la vía preferente.',
  'Incrementar la marcha antes de que pase el otro vehículo.',
  'Prohibición total de realizar giros a la izquierda.',
  'B',
  'A diferencia del PARE (detención obligatoria absoluta), CEDA EL PASO exige aminorar y detenerse únicamente si la vía preferente está ocupada o se aproxima un vehículo.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-02',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-02.png'
),

-- 141. [GENERAL] Señal Informativa de Servicio Médico (SI-01)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica una señal rectangular de fondo azul con el pictograma de una cruz blanca o roja?',
  'Obligación de someterse a prueba médica.',
  'Proximidad de un centro hospitalario o puesto de primeros auxilios.',
  'Zona de riesgo biológico en la calzada.',
  'Prohibición de emitir ruidos de corneta.',
  'B',
  'Es una señal informativa de servicios generales que orienta al conductor sobre la ubicación de puestos de atención de salud en la ruta.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SI-01',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SI-01.png'
),

-- 142. [GENERAL] Mensajes Variables en Vías
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es la ventaja funcional de los Paneles de Mensaje Variable (PMV) instalados en corredores viales?',
  'Sustituir de manera definitiva a los agentes de tránsito.',
  'Proporcionar información dinámica y en tiempo real sobre incidentes, clima o desvíos.',
  'Cobrar automáticamente los peajes a los vehículos en movimiento.',
  'Emitir señales auditivas para despabilar a los conductores cansados.',
  'B',
  'Los Paneles de Mensaje Variable transmiten información cambiante y relevante al instante, alertando sobre siniestros repentinos, congestión o cierres de vía.',
  'Manual de Señalización Vial',
  'Capítulo 6 - Dispositivos Electrónicos',
  'Resolución 20223040045295 de 2022',
  NULL
),

-- 143. [GENERAL] Señalización Temporal de Obras
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿De qué color característico es el fondo de las señales viales de carácter temporal instaladas por ejecución de obras en la vía?',
  'Azul reflectivo.',
  'Naranja.',
  'Amarillo fluorescente.',
  'Verde esmeralda.',
  'B',
  'Las señales de obras usan el color naranja de fondo para advertir intervenciones temporales, presencia de trabajadores y maquinaria en la calzada.',
  'Manual de Señalización Vial',
  'Capítulo 4 - Señalización de Obras',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/senal_obra_naranja.png'
),

-- 144. [GENERAL] Definición de Ciclobanda
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  'A diferencia de una ciclorruta segregada físicamente, ¿cómo se define una ciclobanda?',
  'Un camino exclusivo para bicicletas construido dentro de los parques.',
  'Un carril demarcado en la calzada mediante pintura y dispositivos de canalización (estoperoles, delineadores).',
  'Un andén peatonal compartido con motocicletas.',
  'Una vía rápida sin límites de velocidad para ciclistas de carreras.',
  'B',
  'La ciclobanda forma parte de la calzada vehicular pero se delimita mediante demarcación horizontal y elementos plásticos o hito canalizadores para uso preferente de ciclistas.',
  'Manual de Señalización Vial y Ley ProBici',
  'Capítulo 3 y Definiciones',
  'Ley 1811 de 2016',
  NULL
),

-- 145. [GENERAL] Revisión Preoperacional del Vehículo
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Con qué periodicidad debe llevarse a cabo la inspección preoperacional preventiva de un vehículo automotor?',
  'Únicamente cuando el vehículo vaya a ser vendido.',
  'Antes de iniciar cualquier trayecto o jornada de conducción.',
  'Una vez cada tres meses en el taller mecánico.',
  'Exclusivamente en las fechas fijadas para la Revisión Técnico-Mecánica.',
  'B',
  'La revisión preoperacional es un hábito de autocuidado diario que permite detectar fallas evidentes (fugas, llantas bajas, luces fundidas) antes de salir a la vía.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Inspección Preoperacional',
  'ANSV 2026',
  NULL
),

-- 146. [GENERAL] Definición de Seguridad Activa
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué comprende el concepto de Seguridad Activa o Primaria en la ingeniería automotriz?',
  'Los elementos que protegen el cuerpo humano durante la colisión.',
  'El conjunto de sistemas que contribuyen a evitar que el siniestro llegue a producirse (ej. frenos, dirección, luces).',
  'El seguro obligatorio SOAT y las pólizas contractuales.',
  'Las estructuras de deformación programada del chasis.',
  'B',
  'La seguridad activa engloba todos los componentes encargados de garantizar el control, la estabilidad y la detención oportuna del vehículo para prevenir accidentes.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistemas Activos del Vehículo',
  'ANSV 2026',
  NULL
),

-- 147. [GENERAL] Funcionamiento del Sistema ABS
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál es la función específica del sistema antibloqueo de frenos (ABS) durante un frenado pánico?',
  'Bloquear firmemente las ruedas para arrastrar el vehículo en menor distancia.',
  'Evitar el bloqueo o patinamiento de las ruedas para mantener el control direccional de la guía.',
  'Desconectar automáticamente el motor para evitar incendios.',
  'Activar de forma simultánea las bolsas de aire.',
  'B',
  'Al evitar que las ruedas se queden trabadas, el sistema ABS permite al conductor seguir maniobrando el volante mientras frena a fondo en emergencias.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistema de Frenado ABS',
  'ANSV 2026',
  NULL
),

-- 148. [GENERAL] Freno de Estacionamiento (De Mano)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Sobre qué elemento mecánico actúa normalmente el freno de estacionamiento o de mano en los automóviles?',
  'Directamente sobre la transmisión o las ruedas traseras de forma mecánica o electrónica.',
  'Sobre la caja de dirección evitando que las ruedas giren.',
  'Exclusivamente sobre las ruedas delanteras.',
  'Sobre el pedal del acelerador trabando su recorrido.',
  'A',
  'El freno de parqueo aplica presión sobre los frenos traseros de manera independiente al sistema hidráulico principal para mantener inmóvil el vehículo detenido.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Frenos de Parqueo',
  'ANSV 2026',
  NULL
),

-- 149. [GENERAL] Color de Luces Traseras de Frenado
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'De acuerdo con las homologaciones técnicas, ¿de qué color obligatorio deben emitir luz los faros traseros al presionar el pedal de freno?',
  'Blanco intenso.',
  'Rojo.',
  'Amarillo o ámbar.',
  'Azul purpura.',
  'B',
  'La luz roja en la parte posterior del vehículo está estandarizada universalmente para alertar a los conductores que vienen atrás sobre la disminución de velocidad o detención.',
  'Código Nacional de Tránsito y Reglamento Técnico',
  'Artículo 86 - Luces Reglamentarias',
  'Ley 769 de 2002',
  NULL
),

-- 150. [GENERAL] Luz de Reversa o Retroceso
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿De qué color deben ser las luces traseras que se iluminan automáticamente al enganchar la marcha hacia atrás (reversa)?',
  'Rojo intermitente.',
  'Blanco.',
  'Verde.',
  'Naranja brillante.',
  'B',
  'Las luces blancas de reversa cumplen doble función: iluminar el camino posterior e indicar a otros usuarios que el vehículo se moverá en sentido inverso.',
  'Código Nacional de Tránsito',
  'Artículo 86 - Dispositivos Luminosos',
  'Ley 769 de 2002',
  NULL
),

-- 151. [GENERAL] Función de los Catadióptricos
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué es y qué función cumple un dispositivo catadióptrico o de retroreflexión instalado en los vehículos?',
  'Un bombillo halógeno de gran consumo.',
  'Un elemento reflectivo que devuelve la luz recibida de otros faros para indicar la presencia del vehículo en la penumbra.',
  'Un sensor de reversa para parqueo.',
  'Un fusible del sistema de encendido.',
  'B',
  'Los catadióptricos no generan luz propia; reflejan la luz emitida por los faros de otros vehículos, haciendo visible el auto o moto incluso si está apagado.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Iluminación y Visibilidad',
  'ANSV 2026',
  NULL
),

-- 152. [GENERAL] Lectura de Nomenclatura de Llantas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'En la inscripción impresa sobre el costado de una llanta que marca "205/55 R16", ¿qué representa el número 205?',
  'El diámetro del rín en pulgadas.',
  'El ancho de la sección de la llanta expresado en milímetros.',
  'El porcentaje del perfil de la llanta.',
  'El límite máximo de velocidad en km/h.',
  'B',
  'El primer número de la nomenclatura (205) corresponde al ancho nominal de la banda de rodadura de la llanta medido de flanco a flanco en milímetros.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Especificaciones de Neumáticos',
  'ANSV 2026',
  '/assets/images/illustrations/nomenclatura_llanta.png'
),

-- 153. [GENERAL] Amortiguadores Deteriorados
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué consecuencia grave genera sobre la conducción el estado defectuoso o vencido de los amortiguadores del vehículo?',
  'Incremento apreciable en la distancia de frenado y pérdida de contacto de las llantas con el suelo en baches.',
  'Disminución del consumo de combustible.',
  'Aumento repentino en la presión del aire de las llantas.',
  'Bloqueo permanente del sistema de climatización.',
  'A',
  'Los amortiguadores agotados hacen que las llantas reboten, perdiendo adherencia con el pavimento. Esto alarga la distancia de detención y desestabiliza las curvas.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistema de Suspensión',
  'ANSV 2026',
  NULL
),

-- 154. [GENERAL] Complementariedad de Airbag y Cinturón
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál es la relación de funcionamiento entre las bolsas de aire (airbags) y el cinturón de seguridad?',
  'El airbag reemplaza el uso del cinturón en vías urbanas.',
  'El airbag es un sistema complementario que solo funciona eficientemente si el ocupante lleva abrochado el cinturón.',
  'El cinturón solo debe usarse si el auto no posee airbags activos.',
  'Funcionan de manera opuesta: usarlos juntos incrementa las lesiones.',
  'B',
  'Sin el cinturón abrochado, el cuerpo se desplaza bruscamente hacia adelante en un choque y la bolsa al desplegarse a alta velocidad puede causar heridas graves o fatales.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Seguridad Pasiva',
  'ANSV 2026',
  NULL
),

-- 155. [GENERAL] Uso del Cinturón en Mujeres Embarazadas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál es la instrucción correcta sobre el uso del cinturón de seguridad en mujeres gestantes?',
  'Están exentas de usar cinturón por riesgo de presión en el vientre.',
  'Deben utilizarlo obligatoriamente ubicando la cinta pélvica por debajo del vientre y la cinta torácica entre los senos.',
  'Deben sentarse exclusivamente en la parte posterior sin cinturón.',
  'Solo deben usar la banda diagonal sobre el hombro.',
  'B',
  'El cinturón protege tanto a la madre como al feto en un choque. Su colocación correcta evita la presión directa sobre el útero en deceleraciones bruscas.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Uso Correcto de Dispositivos',
  'ANSV 2026',
  '/assets/images/illustrations/cinturon_embarazada.png'
),

-- 156. [GENERAL] Equipo de Carretera Obligatorio - Gato
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'De acuerdo con el Artículo 30 del CNT, ¿cuál de los siguientes elementos forma parte del kit o equipo reglamentario de carretera?',
  'Un gato hidráulico o mecánico con capacidad para elevar el vehículo.',
  'Un compresor eléctrico de aire.',
  'Una cámara fotográfica profesional.',
  'Un cargador portátil de baterías de 24 voltios.',
  'A',
  'El gato con capacidad acorde al peso del automóvil es un elemento exigido en el kit mínimo de prevención y seguridad para el cambio de neumáticos en carretera.',
  'Código Nacional de Tránsito',
  'Artículo 30 - Equipo de Carretera',
  'Ley 769 de 2002',
  NULL
),

-- 157. [GENERAL] Equipo de Carretera Obligatorio - Señales
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuántas señales de peligro (triángulos reflectivos o conos) exige la norma portar dentro del equipo de carretera?',
  'Una sola señal.',
  'Dos señales en forma de triángulo con soporte para sostenerse en pie o conos reflectivos.',
  'Cuatro señales luminosas azules.',
  'No son obligatorias si se usan las luces de parqueo.',
  'B',
  'La ley exige llevar como mínimo dos señales reflectivas para advertir la presencia del vehículo varado o accidentado tanto en la parte delantera como posterior.',
  'Código Nacional de Tránsito',
  'Artículo 30 - Equipo de Prevención',
  'Ley 769 de 2002',
  NULL
),

-- 158. [MOTO] Elemento de Protección Obligatorio
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Cuál es el elemento de protección personal exigido legalmente y de carácter obligatorio para conductores y acompañantes de motocicletas?',
  'Chaqueta de cuero con protecciones rígidas.',
  'Casco reglamentario debidamente abrochado y certificado.',
  'Botas caña alta con puntera de acero.',
  'Guantes de protección contra abrasión.',
  'B',
  'El uso del casco reglamentario y bien ajustado es el único elemento de protección personal obligatorio por ley, reduciendo drásticamente la mortalidad por trauma craneoencefálico.',
  'Resolución de Cascos y CNT',
  'Artículo 94 y NTC 4533',
  'Resolución 23385 de 2020',
  NULL
),

-- 159. [MOTO] Ajuste del Sistema de Retención del Casco
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Al ponerse el casco de protección para transitar en motocicleta, ¿cómo debe posicionarse la correa de retención?',
  'Suelta para permitir el flujo de aire al cuello.',
  'Asegurada y abrochada por debajo de la mandíbula inferior sin juego excesivo.',
  'Ubicada por encima del mentón.',
  'Enrollada alrededor del manubrio de la moto.',
  'B',
  'Un casco desabrochado o mal ajustado sale despedido de la cabeza en el primer impacto de un siniestro, dejando al usuario totalmente desprotegido.',
  'Resolución de Cascos ANSV',
  'Condiciones de Uso del Casco',
  'Resolución 23385 de 2020',
  '/assets/images/illustrations/ajuste_casco_moto.png'
),

-- 160. [MOTO] Uso de Teléfonos Celulares dentro del Casco
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Está permitido ubicar el teléfono celular entre la cabeza y el casco de protección mientras se conduce una motocicleta?',
  'Sí, siempre que no entorpezca la visión frontal.',
  'No, está expresamente prohibido por interferir con el ajuste y causar distracción.',
  'Sí, en trayectos urbanos cortos.',
  'Sí, únicamente si se utiliza en modo altavoz.',
  'B',
  'Ubicar el teléfono dentro del casco altera la correcta sujeción del elemento de protección, resta campo auditivo y genera distracción severa.',
  'Resolución de Cascos ANSV',
  'Uso de Dispositivos de Comunicación',
  'Resolución 23385 de 2020',
  NULL
),

-- 161. [MOTO] Circulación entre Carriles (Zizagüeado / Culebreo)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Cuál es la norma de tránsito sobre adelantar o zigzaguear entre vehículos que transitan en movimiento sobre sus respectivos carriles?',
  'Está permitido si se encienden las luces direccionales.',
  'Está prohibido; la motocicleta debe ocupar un carril y realizar adelantamientos respetando el espacio como cualquier automotor.',
  'Está permitido únicamente para motocicletas de bajo cilindraje (menos de 125 cc).',
  'Está permitido en vías de más de tres carriles.',
  'B',
  'Transitar entre carriles de vehículos en movimiento (el llamado zizagüeado) genera puntos ciegos y alto riesgo de colisión. Las motos deben conservar su carril.',
  'Código Nacional de Tránsito',
  'Artículo 96 - Normas Específicas para Motocicletas',
  'Ley 769 de 2002',
  NULL
),

-- 162. [MOTO] Uso de Chaqueta / Prenda Reflectiva Nocturna
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'En Colombia, ¿en qué horario es obligatorio para conductores y acompañantes de motocicleta vestir prenda o chaleco reflectivo?',
  'Solamente entre las 00:00 y las 04:00 horas.',
  'Entre las 18:00 horas y las 06:00 horas del día siguiente, o cuando la visibilidad sea escasa.',
  'Únicamente en carreteras departamentales o nacionales.',
  'No es obligatorio si la motocicleta tiene encendida la luz trasera.',
  'B',
  'El uso de prendas reflectivas entre las 6:00 p.m. y las 6:00 a.m. incrementa significativamente la visibilidad del motociclista ante los demás conductores en la vía.',
  'Código Nacional de Tránsito',
  'Artículo 94 - Visibilidad del Motociclista',
  'Ley 769 de 2002',
  '/assets/images/illustrations/chaleco_reflectivo_moto.png'
),

-- 163. [MOTO] Encendido Permanente de Luces en Motocicletas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Cuál es la exigencia legal sobre el uso de la luz frontal en motocicletas al circular durante el día?',
  'Deben encenderse únicamente en zonas rurales o carreteras.',
  'Deben transitar en todo momento (las 24 horas del día) con la luz delantera encendida.',
  'Solo se requiere encender la luz si el día está nublado.',
  'Está prohibido encender luces de día para evitar desgastar la batería.',
  'B',
  'Las motocicletas deben mantener encendida la luz frontal de forma permanente (día y noche) para hacerse visibles a larga distancia a través de los retrovisores.',
  'Código Nacional de Tránsito y Ley ProBici',
  'Artículo 96 - Visibilidad de Motocicletas',
  'Ley 769 de 2002',
  NULL
),

-- 164. [MOTO] Transporte de Cargas Prominentes en Moto
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Está permitido transportar en una motocicleta objetos o sobresaltos que sobresalgan por los laterales o entorpezcan la visibilidad y maniobrabilidad?',
  'Sí, siempre que se coloque una bandera roja en la punta.',
  'No, está prohibido transportar objetos de volumen que pongan en peligro la estabilidad del vehículo o la seguridad de terceros.',
  'Sí, en distancias menores a 5 kilómetros.',
  'Sí, únicamente si la carga va amarrada en la parrilla trasera.',
  'B',
  'Transportar carga sobredimensionada desestabiliza el centro de gravedad del vehículo de dos ruedas y expone a otros usuarios a enganches o golpes.',
  'Código Nacional de Tránsito',
  'Artículo 94 - Restricciones de Carga en Motos',
  'Ley 769 de 2002',
  NULL
),

-- 165. [MOTO] Transporte de Menores de Edad en Motocicleta
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'De acuerdo con las regulaciones de movilidad y seguridad infantil, ¿a partir de qué condición/edad está prohibido o restringido el transporte de niños en moto?',
  'Se pueden llevar si acomodan los pies en los posapiés y sujetan al conductor, estando prohibido el traslado de menores de 10 años en varios municipios por decreto local.',
  'Pueden ir ubicados en el tanque de gasolina si llevan casco.',
  'Pueden ir en medio de dos adultos sin necesidad de posapiés.',
  'No existe ninguna restricción de edad para acompañantes en moto.',
  'A',
  'Para ser acompañante en moto, la persona debe alcanzar los posapiés traseros con los pies apoyados. Además, múltiples municipios prohíben expresamente el traslado de menores de 10 años.',
  'Manual de Referencia ANSV y Decretos Territoriales',
  'Módulo 5 - Pasajeros Vulnerables en Moto',
  'ANSV 2026',
  NULL
),

-- 166. [MOTO] Técnica de Mirada en Curvas para Motociclistas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Al tomar una curva en motocicleta, ¿hacia dónde debe dirigir la mirada el conductor para trazar el giro de forma segura?',
  'Hacia la llanta delantera para vigilar el terreno cercano.',
  'Hacia la salida de la curva (punto de fuga) adonde se pretende dirigir la motocicleta.',
  'Hacia el borde del sardinel del carril contrario.',
  'Exclusivamente al velocímetro del tablero.',
  'B',
  'En la motocicleta se aplica la regla de "la moto va hacia donde mira el conductor". Fijar la vista en el punto de salida asegura la trayectoria y estabilidad adecuada.',
  'Manual de Referencia ANSV',
  'Módulo 5 - Trazado y Visión en Curva',
  'ANSV 2026',
  NULL
),

-- 167. [MOTO] Postura de los Pies sobre los Posapiés
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Cuál es la ubicación correcta de los pies del conductor mientras la motocicleta se encuentra en marcha?',
  'Con las puntas hacia afuera apuntando al piso por si requiere apoyarse.',
  'Apoyando la parte media o metatarso del pie sobre los posapiés, paralelos al chasis y cerca de los mandos de freno/cambios.',
  'Arrastrando las suelas sobre el pavimento a baja velocidad.',
  'Descansando los talones sobre la defensa o protector de motor.',
  'B',
  'Mantener las puntas de los pies hacia abajo o afuera expone las extremidades a enganches con el asfalto u otros vehículos y retrasa el accionamiento de los pedales.',
  'Manual de Referencia ANSV',
  'Módulo 5 - Postura Ergonómica del Motociclista',
  'ANSV 2026',
  NULL
),

-- 168. [MOTO] Peligro de Pintura / Demarcaciones Mojadas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Por qué las demarcaciones de pintura sobre la calzada (cebras, flechas) representan un peligro severo para las motocicletas en días lluviosos?',
  'Porque la pintura disuelve el compuesto de caucho de las llantas.',
  'Porque la pintura húmeda reduce fuertemente el coeficiente de fricción, provocando pérdidas instantáneas de adherencia.',
  'Porque rebotan las luces altas cegando al motociclista.',
  'Porque desgastan las bandas de freno traseras.',
  'B',
  'La pintura vial mojada se torna sumamente resbaladiza. Se recomienda transitar sobre ella con la motocicleta recta, sin inclinar ni realizar frenadas bruscas.',
  'Manual de Referencia ANSV',
  'Módulo 5 - Adherencia y Riesgos Urbanos',
  'ANSV 2026',
  NULL
),

-- 169. [MOTO] Reemplazo de Casco tras un Impacto
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  'Si un casco de protección sufre una caída fuerte o se ve involucrado en un siniestro vial, ¿qué se debe hacer con él aunque no presente grietas visibles por fuera?',
  'Continuar usándolo si la pintura exterior está intacta.',
  'Sustituirlo por uno nuevo, pues la estructura interna de absorción (EPS/Icopor) pierde su capacidad protectora tras deformarse.',
  'Lavar el interior y volverlo a ajustar.',
  'Colocarle un sticker de refuerzo en la zona del golpe.',
  'B',
  'El poliestireno expandido (EPS) interno absorbe el impacto deformándose una sola vez. Tras sufrir un golpe fuerte, el casco pierde su efectividad y debe ser desechado.',
  'Resolución de Cascos ANSV',
  'Mantenimiento y Vida Útil del Casco',
  'Resolución 23385 de 2020',
  NULL
),

-- 170. [MOTO] Presión de Aire en Llantas de Moto
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'safe_mobility',
  '¿Qué ocurre si una motocicleta circula con las llantas por debajo de la presión (PSI) recomendada por el fabricante?',
  'Mejora la velocidad máxima del vehículo.',
  'Se torna pesada e inestable en las curvas, se deforma la carcasa del neumático y aumenta el consumo de gasolina.',
  'Disminuye la distancia de frenado a la mitad.',
  'Evita pinchazos por objetos punzantes.',
  'B',
  'Circular con baja presión genera inestabilidad direccional, sobrecalienta la estructura de la llanta y provoca un desgaste irregular acelerado en los hombros del neumático.',
  'Manual de Referencia ANSV',
  'Módulo 5 - Mantenimiento de Neumáticos',
  'ANSV 2026',
  NULL
),

-- 171. [GENERAL] Uso de Direccionales antes de un Giro
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Con qué anticipación mínima se debe indicar una maniobra de giro o cambio de carril mediante el uso de las luces direccionales en zonas urbanas?',
  'Al instante exacto de realizar el giro.',
  'Con al menos 30 metros de antelación al punto de la maniobra.',
  'Con 5 metros de anticipación.',
  'No es obligatorio usar direccionales si no vienen vehículos detrás.',
  'B',
  'Advertir el giro con mínimo 30 metros de anticipación brinda el tiempo necesario para que los conductores posteriores ajusten su distancia y eviten colisiones por alcance.',
  'Código Nacional de Tránsito',
  'Artículo 67 - Indicación de Senales de Giro',
  'Ley 769 de 2002',
  NULL
),

-- 172. [GENERAL] Señal Manual de Giro a la Izquierda
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Si las luces direccionales del vehículo presentan una falla inesperada, ¿cuál es la señal manual reglamentaria para indicar un giro a la izquierda?',
  'Extender el brazo izquierdo de forma horizontal fuera del vehículo.',
  'Colocar el brazo izquierdo en ángulo recto apuntando hacia el cielo.',
  'Sacar el brazo y moverlo en círculos.',
  'Sacar el brazo derecho por la ventana del pasajero.',
  'A',
  'El brazo izquierdo extendido horizontalmente es la convención universal para notificar a los demás actores viales la intención de virar hacia la izquierda.',
  'Código Nacional de Tránsito',
  'Artículo 69 - Señales Manuales',
  'Ley 769 de 2002',
  '/assets/images/illustrations/senal_manual_izquierda.png'
),

-- 173. [GENERAL] Señal Manual de Giro a la Derecha
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cómo debe indicarse manualmente la intención de girar hacia la derecha ante una avería del sistema eléctrico?',
  'Extender el brazo izquierdo en posición horizontal.',
  'Extender el brazo izquierdo hacia afuera y doblarlo hacia arriba en ángulo recto (90°).',
  'Sacar el brazo e inclinarlo hacia el piso.',
  'Encender y apagar las luces medias repetidamente.',
  'B',
  'El brazo izquierdo doblado en ángulo de 90 grados apuntando hacia arriba notifica a los vehículos traseros la maniobra de viraje hacia la derecha.',
  'Código Nacional de Tránsito',
  'Artículo 69 - Señales Manuales',
  'Ley 769 de 2002',
  '/assets/images/illustrations/senal_manual_derecha.png'
),

-- 174. [GENERAL] Señal Manual para Disminuir la Velocidad
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuál es el gesto manual normado para indicar a los conductores posteriores que se va a aminorar la marcha o detener el vehículo?',
  'Extender el brazo izquierdo hacia abajo con la palma de la mano orientada hacia atrás.',
  'Mover el brazo en círculos por encima del techo.',
  'Apuntar con el índice hacia el parabrisas.',
  'Mantener el brazo rígido apuntando hacia adelante.',
  'A',
  'El brazo izquierdo extendido hacia abajo notifica la disminución progresiva de la velocidad o la detención del automotor.',
  'Código Nacional de Tránsito',
  'Artículo 69 - Señales Manuales',
  'Ley 769 de 2002',
  '/assets/images/illustrations/senal_manual_detencion.png'
),

-- 175. [GENERAL] Luces de Estacionamiento o Parqueo (Flashing)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿En qué situación específica deben accionarse las luces intermitentes de estacionamiento (luces de peligro)?',
  'Para adelantar rápidamente a otro vehículo en carretera.',
  'Para indicar una detención de emergencia, un vehículo varado o una situación de peligro inminente en la vía.',
  'Para cruzar una intersección con el semáforo en amarillo.',
  'Para solicitar paso en una zona de parqueo congestionada.',
  'B',
  'Las luces de peligro activan ambas direccionales simultáneamente y sirven únicamente para advertir varadas, detenciones forzosas o riesgos imprevistos.',
  'Código Nacional de Tránsito',
  'Artículo 86 - Uso de Dispositivos Luminosos',
  'Ley 769 de 2002',
  NULL
),

-- 176. [GENERAL] Tránsito por Carriles de Uso Exclusivo (SITP / TransMilenio)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Puede un vehículo particular o motocicleta invadir o circular por los carriles dedicados exclusivamente al transporte masivo?',
  'Sí, si el conductor paga la tarifa de peaje urbano.',
  'No, está rotundamente prohibido e incurre en sanción y probable inmovilización.',
  'Sí, en horas pico para descongestionar la vía ordinaria.',
  'Sí, siempre y cuando transporte más de cuatro ocupantes.',
  'B',
  'Los carriles exclusivos están reservados para el sistema masivo de pasajeros con el fin de optimizar tiempos. Invadir este carril genera graves riesgos de choque e infracción.',
  'Código Nacional de Tránsito',
  'Artículo 131 - Infracción C.14',
  'Ley 769 de 2002',
  NULL
),

-- 177. [GENERAL] Uso de bocina / corneta / pito
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuál es el uso legal y permitido del dispositivo sonoro (pito o corneta) en un vehículo?',
  'Para apresurar a los peatones en el cruce de cebra.',
  'Exclusivamente para prevenir situaciones de peligro o siniestro inminente.',
  'Para avisar la apertura del semáforo en verde al vehículo de adelante.',
  'Para saludar a otros usuarios o hacer reclamos de tráfico.',
  'B',
  'El pito es una herramienta de alerta de emergencia. Su uso indebido o desmedido genera contaminación auditiva e incita la agresividad al volante.',
  'Código Nacional de Tránsito',
  'Artículo 104 - Uso del Pito o Bocina',
  'Ley 769 de 2002',
  NULL
),

-- 178. [GENERAL] Prohibición de Bocina cerca de Centros de Salud
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿En qué lugares está terminantemente prohibido hacer uso de la bocina o pito salvo emergencia extrema?',
  'En autopistas de alta velocidad.',
  'Frente a hospitales, clínicas, centros de salud y zonas escolares.',
  'Dentro de parqueaderos subterráneos privados.',
  'En las estaciones de servicio de combustible.',
  'B',
  'En las inmediaciones de hospitales, sanatorios y centros educativos rige la restricción de emisiones sonoras para garantizar la tranquilidad y recuperación de los pacientes.',
  'Código Nacional de Tránsito',
  'Artículo 104 - Zonas de Silencio',
  'Ley 769 de 2002',
  '/assets/images/signals/SR-31.png'
),

-- 179. [GENERAL] Infracción por Transitar sin SOAT Vigente
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Qué sanción aplica la autoridad de tránsito al constatar que un vehículo circula sin la póliza SOAT vigente?',
  'Amonestación escrita y llamado de atención.',
  'Multa equivalente a 30 salarios mínimos legales diarios vigentes (SMLDV) e inmovilización inmediata del vehículo.',
  'Suspensión definitiva de la licencia de conducción.',
  'Retención temporal del documento de identidad.',
  'B',
  'Manejar sin SOAT no solo deja desamparadas a las víctimas ante un siniestro, sino que acarrea una multa cuantiosa y el traslado del automotor a los patios.',
  'Código Nacional de Tránsito',
  'Artículo 131 - Infracción C.35',
  'Ley 769 de 2002',
  NULL
),

-- 180. [GENERAL] Caducidad y Vigencia de la RTM
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'En un vehículo particular nuevo, ¿a partir de qué año contado desde su fecha de matrícula debe comenzar a realizarse la Revisión Técnico-Mecánica (RTM) anual?',
  'Al finalizar el primer año.',
  'A partir del quinto (5°) año contado desde la fecha de su matrícula.',
  'Al cumplir 10 años de uso.',
  'Solamente cuando el vehículo cambie de propietario.',
  'B',
  'Según las actualizaciones de ley (Ley 2294), los vehículos particulares nuevos deben presentar su primera revisión técnico-mecánica y de gases a los 5 años de matriculados.',
  'Código Nacional de Tránsito y Ley de Plan de Desarrollo',
  'Artículo 52 - Periodicidad RTM',
  'Ley 2294 de 2023',
  NULL
),

-- 181. [GENERAL] Periodicidad RTM en Servicio Público y Motos
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Cuándo deben realizar la primera Revisión Técnico-Mecánica los vehículos de servicio público y las motocicletas inscritas en el RUNT?',
  'A los 5 años de matriculados.',
  'Al cumplir dos (2) años contados a partir de la fecha de su matrícula.',
  'A los 3 años de uso.',
  'A los 6 meses de comprados.',
  'B',
  'Debido al alto nivel de desgaste y exposición al riesgo, los vehículos de servicio público y todas las motocicletas deben realizar su primera RTM a los 2 años de matrícula.',
  'Código Nacional de Tránsito',
  'Artículo 52 - RTM Servicio Público y Motos',
  'Ley 769 de 2002',
  NULL
),

-- 182. [GENERAL] Definición de Glorieta / Rotonda
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'En una intersección tipo glorieta o rotonda, ¿quién tiene la prioridad o prelación de paso legal?',
  'El vehículo que se dispone a ingresar a la glorieta.',
  'El vehículo que ya se encuentra circulando dentro de la glorieta.',
  'El vehículo que transita por el carril exterior únicamente.',
  'El vehículo de mayor cilindraje o masa.',
  'B',
  'Quienes están dentro del anillo de la glorieta tienen la prelación. Los vehículos que pretenden ingresar deben esperar a que haya un espacio seguro.',
  'Código Nacional de Tránsito',
  'Artículo 70 - Prelación en Glorietas',
  'Ley 769 de 2002',
  '/assets/images/illustrations/prelacion_glorieta.png'
),

-- 183. [GENERAL] Salida de la Glorieta
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Para abandonar una glorieta de múltiples carriles de forma correcta, el conductor debe:',
  'Girar bruscamente desde el carril interno hacia la salida.',
  'Ubicarse con anticipación en el carril exterior (derecho) e anunciar la salida con la luz direccional.',
  'Detenerse completamente en el centro hasta que no hayan autos.',
  'Pitar continuamente para abrirse paso hacia la ramificación.',
  'B',
  'Toda salida de glorieta exige un cambio progresivo hacia el carril externo antes del empalme para no cortar la trayectoria de quienes continúan girando.',
  'Manual de Referencia ANSV',
  'Módulo 2 - Maniobras en Rotondas',
  'ANSV 2026',
  NULL
),

-- 184. [GENERAL] Adelantamiento en Puentes o Viaductos
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Está permitido realizar maniobras de adelantamiento a otros vehículos cuando se transita sobre puentes, túneles o pasajes subterráneos?',
  'Sí, siempre que se superen los 60 km/h.',
  'No, está expresamente prohibido adelantar en puentes, viaductos y túneles.',
  'Sí, únicamente a motocicletas y bicicletas.',
  'Sí, si la vía cuenta con iluminación artificial.',
  'B',
  'Los puentes y túneles son zonas de espacio reducido y confinamiento vial donde un choque frontal o lateral genera bloqueos catastróficos; adelantar está prohibido.',
  'Código Nacional de Tránsito',
  'Artículo 60 - Prohibición de Adelantamiento',
  'Ley 769 de 2002',
  NULL
),

-- 185. [GENERAL] Cruce de Pasos a Nivel (Vía Férrea)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al aproximarse a un cruce con la vía férrea (paso a nivel), ¿cuál es la conducta reglamentaria que debe realizar el conductor?',
  'Acelerar para cruzar antes de que aparezca el tren.',
  'Detener la marcha a una distancia mínima de 5 metros del riel y verificar la ausencia de trenes antes de cruzar.',
  'Tocar la corneta continuamente mientras avanza.',
  'Encender las luces altas y pasar sin detenerse.',
  'B',
  'El tren tiene la prelación absoluta por su prolongada distancia de frenado. Los vehículos deben detenerse por completo antes de atravesar las vías férreas.',
  'Código Nacional de Tránsito',
  'Artículo 77 - Pasos a Nivel',
  'Ley 769 de 2002',
  '/assets/images/signals/SP-28.png'
),

-- 186. [GENERAL] Prelación de Vehículos de Emergencia
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'Al percibir las señales lumínicas (módulos estroboscópicos) y auditivas (sirena) de una ambulancia o vehículo de bomberos, ¿qué deben hacer los demás conductores?',
  'Aumentar la velocidad para abrirles paso adelante.',
  'Ceder el paso orillándose hacia la derecha de la calzada y deteniéndose si es necesario.',
  'Seguirlos de cerca para aprovechar la vía despejada.',
  'Continuar la marcha normal sin cambiar de carril.',
  'B',
  'Los vehículos de socorro en misión médica o de emergencia tienen prioridad absoluta. Los demás usuarios deben despejar el carril orillándose a la derecha.',
  'Código Nacional de Tránsito',
  'Artículo 64 - Cesión de Paso a Emergencias',
  'Ley 769 de 2002',
  NULL
),

-- 187. [GENERAL] Transporte de Niños en Asientos Delanteros
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  'De acuerdo con las disposiciones de seguridad vial, ¿cuál es la edad mínima reglamentaria para que un menor pueda viajar en el asiento delantero de un automóvil?',
  '5 años.',
  '10 años.',
  '7 años.',
  '12 años.',
  'B',
  'Los menores de 10 años deben viajar obligatoriamente en los asientos traseros del vehículo y con los Sistemas de Retención Infantil (SRI) acordes a su peso y talla.',
  'Código Nacional de Tránsito y Resoluciones ANSV',
  'Artículo 82 - Transporte de Niños',
  'Ley 769 de 2002',
  NULL
),

-- 188. [GENERAL] Uso de Sistemas de Retención Infantil (SRI)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'traffic_rules',
  '¿Por qué se exige el uso de sillas infantiles (SRI) en lugar de llevar a los bebés cargados en los brazos de un adulto en el asiento trasero?',
  'Por comodidad de espacio en el baúl.',
  'Porque en una colisión a 50 km/h la fuerza de inercia multiplica el peso del bebé haciéndolo imposible de sostener con los brazos.',
  'Para evitar que los niños manchen la cojinería.',
  'Porque reduce el consumo de combustible por peso.',
  'B',
  'En un impacto, la fuerza cinemática convierte a un infante suelto o cargado en un proyectil inviable de retener manualmente, provocando lesiones fatales.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistemas de Retención Infantil',
  'ANSV 2026',
  '/assets/images/illustrations/silla_infantil_sri.png'
),

-- 189. [GENERAL] Señal Preventiva Zona de Derrape (SP-23)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué advierte la señal preventiva que exhibe un automotor con trazos serpenteantes en sus llantas (SP-23)?',
  'Zona de venta de neumáticos.',
  'Proximidad a un tramo de calzada resbaladiza o con baja fricción.',
  'Inicio de zona de piques o carreras autorizadas.',
  'Pistas para prueba de sistemas de frenos.',
  'B',
  'La señal advertencia de superficie resbaladiza alerta sobre pérdida de fricción imprevista por humedad, grasa o grava suelta en la calzada.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SP-23',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-23.png'
),

-- 190. [GENERAL] Señal Preventiva Reducción de Calzada (SP-15)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indica una señal preventiva con líneas que se estrechan en el centro o hacia un costado (SP-15)?',
  'Aumento del número de carriles disponibles.',
  'Estrechamiento o reducción del ancho de la calzada en el tramo subsiguiente.',
  'Inicio de una zona peatonal exclusiva.',
  'Proximidad de una báscula para camiones.',
  'B',
  'Advierte la reducción del espacio de circulación, exigiendo reacomodar la velocidad y la distancia lateral con otros vehículos para evitar roces o embotellamientos.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SP-15',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SP-15.png'
),

-- 191. [GENERAL] Señal Reglamentaria Prohibido Girar en "U" (SR-06)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué maniobra prohíbe la señal reglamentaria con una flecha en forma de curva descendente tachada por una diagonal roja (SR-06)?',
  'El giro hacia la derecha en la intersección.',
  'Dar la vuelta en "U" o retornar sobre la misma vía en sentido contrario.',
  'Adelantar en zona escolar.',
  'Dar marcha atrás en reversa.',
  'B',
  'La señal prohibe efectuar el viraje de 180 grados (retorno en U) por representar un peligro de colisión lateral o bloqueo de flujo en corredores de tráfico.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-06',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-06.png'
),

-- 192. [GENERAL] Señal Reglamentaria Altura Máxima Permitida (SR-28)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué restricción comunica la señal circular con borde rojo que contiene una cifra acompañada de flechas verticales apuntando hacia arriba y abajo (SR-28)?',
  'El peso límite de los camiones por eje.',
  'La altura máxima permitida para los vehículos que ingresan a la vía, túnel o puente.',
  'El ancho máximo de la carrocería en metros.',
  'La velocidad máxima en tramos elevados.',
  'B',
  'Indica el gálibo o luz vertical disponible bajo estructuras (puentes, pasarelas, túneles) para evitar el impacto de vehículos sobredimensionados.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-28',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-28.png'
),

-- 193. [GENERAL] Señal Reglamentaria Peso Máximo Total (SR-29)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  'Una señal reglamentaria que exhibe un número seguido de la letra "t" (toneladas) restringe:',
  'El número de pasajeros que pueden viajar.',
  'El peso bruto vehicular máximo permitido para transitar sobre la estructura o vía.',
  'La cantidad de horas de conducción contínuas.',
  'El volumen del tanque de almacenamiento de combustible.',
  'B',
  'Limita la carga total (vehículo + mercancía) para proteger la integridad estructural de puentes, pavimentos o pontones con capacidad reducida.',
  'Manual de Señalización Vial',
  'Capítulo 2 - Señal SR-29',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/SR-29.png'
),

-- 194. [GENERAL] Demarcación de Línea de Detención (Línea de PARE)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Dónde debe detenerse exactamente un vehículo ante un semáforo en rojo o una señal de PARE?',
  'Sobre las rayas del paso peatonal (cebra).',
  'Antes de la línea blanca transversal continua de detención pintada sobre el pavimento.',
  'Un metro después de la señal vertical de PARE invadiendo el cruce.',
  'En el centro de la intersección.',
  'B',
  'La línea de detención delimita el límite físico. Transponerla o detenerse sobre la cebra coloca al vehículo en el espacio exclusivo del peatón o del flujo transversal.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Demarcaciones Transversales',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/linea_detencion.png'
),

-- 195. [GENERAL] Marcación en Cuadrícula Amarilla (Zona Bloqueo de Cruce)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué indicación expresa la demarcación en forma de cuadrícula o red de líneas amarillas diagonales en una intersección (M-13)?',
  'Zona habilitada para el parqueo de taxis.',
  'Prohibición de ingresar o quedar detenido dentro del cruce bloqueando la intersección, aún si el semáforo está en verde.',
  'Carril exclusivo para ambulancias y policía.',
  'Área autorizada para el ascenso y descenso de pasajeros.',
  'B',
  'Las cuadrículas amarillas (box junction) prohíben detener el vehículo dentro de la caja de la intersección para evitar la parálisis del tráfico cruzado.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Demarcación Anti-Bloqueo',
  'Resolución 20223040045295 de 2022',
  '/assets/images/signals/cuadricula_amarilla.png'
),

-- 196. [GENERAL] Marcas Viales de Flechas de Dirección
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Qué función cumplen las flechas blancas pintadas dentro de un carril de circulación?',
  'Decorar la calzada en zonas urbanas.',
  'Indicar la trayectoria o sentidos de giro obligatorios/permitidos para los vehículos que ocupan ese carril específico.',
  'Señalar los sitios con cámaras de foto-detección.',
  'Marcar la velocidad en metros por segundo.',
  'B',
  'Las flechas de carril encauzan el tráfico. Si el carril indica exclusivamente giro a la izquierda, el conductor no debe continuar de frente.',
  'Manual de Señalización Vial',
  'Capítulo 3 - Flechas sobre la Calzada',
  'Resolución 20223040045295 de 2022',
  NULL
),

-- 197. [GENERAL] Delineadores Estoperoles / Estacas (Ojos de Buey)
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'signage_infrastructure',
  '¿Cuál es la finalidad de los dispositivos retroreflectivos adheridos al pavimento (tachas, estoperoles u "ojos de gato")?',
  'Servir de reducedores de velocidad permanentes.',
  'Delimitar los bordes y carriles de la vía bajo condiciones de oscuridad o lluvia intensa.',
  'Medir la velocidad de los automotores mediante sensores.',
  'Evitar el sobrecalentamiento de los neumáticos.',
  'B',
  'Las tachas reflectivas retroiluminan las líneas de demarcación nocturna mediante los faros del auto, guiando la trayectoria en la penumbra o con niebla.',
  'Manual de Señalización Vial',
  'Capítulo 5 - Dispositivos Delimitadores',
  'Resolución 20223040045295 de 2022',
  NULL
),

-- 198. [GENERAL] Indicador de Temperatura del Motor
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'Si durante la marcha el indicador de temperatura del motor en el tablero se eleva hasta la zona roja o se enciende el testigo correspondiente, el conductor debe:',
  'Aumentar la velocidad para que el aire enfríe el radiador.',
  'Detener el vehículo en un lugar seguro, apagar el motor y esperar a que se enfríe antes de revisar líquidos.',
  'Abrir de inmediato la tapa del tanque de expansión de refrigerante con el motor caliente.',
  'Ignorar la señal si el carro no emite ruidos extraños.',
  'B',
  'El sobrecalentamiento destruye empaques y componentes mecánicos. Destapar el radiador caliente expone a quemaduras severas por vapor y agua a presión.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistema de Refrigeración',
  'ANSV 2026',
  '/assets/images/illustrations/testigo_temperatura.png'
),

-- 199. [GENERAL] Presión del Aceite de Motor
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué riesgo crítico anuncia el testigo luminoso con forma de aceitera encendido en el tablero mientras se conduce?',
  'Que el nivel de combustible está bajo.',
  'Pérdida peligrosa en la presión de lubricación del motor, con riesgo de fundición de componentes mecánicos.',
  'Que el freno de mano se encuentra accionado.',
  'Que el aire acondicionado requiere recarga.',
  'B',
  'Sin presión de aceite las piezas metálicas entran en fricción directa, lo que puede destruir el motor en cuestión de minutos. Exige detener la marcha inmediatamente.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistema de Lubricación',
  'ANSV 2026',
  '/assets/images/illustrations/testigo_aceite.png'
),

-- 200. [GENERAL] Función del Filtro de Aire del Motor
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál es el cometido principal del filtro de aire instalado en el motor del vehículo?',
  'Purificar el aire que ingresa a la cabina para los pasajeros.',
  'Retener las impurezas y partículas de polvo antes de que el aire ingrese a la cámara de combustión.',
  'Filtrar los gases que salen por el tubo de escape.',
  'Evitar fugas de líquido de frenos.',
  'B',
  'Un filtro de aire limpio garantiza una mezcla óptima de combustión sin partículas abrasivas que rayen los cilindros ni obstruyan el sistema de admisión.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Sistema de Admisión',
  'ANSV 2026',
  NULL
),

-- 201. [GENERAL] Estado del Líquido de Frenos
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Por qué se debe sustituir periódicamente el líquido de frenos según las recomendaciones del fabricante?',
  'Porque pierde color y mancha los depósitos.',
  'Porque es higroscópico (absorbe humedad del aire), lo que disminuye su punto de ebullición y genera burbujas de vapor inservibles al frenar.',
  'Porque se evapora completamente cada seis meses.',
  'Porque al envejecer se solidifica bloqueando la transmisión.',
  'B',
  'El agua absorbida por el líquido de frenos hierve por el calor del frenado; los vapores resultantes se comprimen, haciendo que el pedal se vaya al fondo sin frenar.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Mantenimiento de Frenos',
  'ANSV 2026',
  NULL
),

-- 202. [GENERAL] Alineación y Balanceo de las Ruedas
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué síntomas manifiestan las ruedas cuando el vehículo requiere un servicio de balanceo?',
  'Olor a quemado al acelerar en pendientes.',
  'Vibraciones en el volante o manubrio a determinadas velocidades (habitualmente superiores a 60 km/h).',
  'Dureza extrema al girar la dirección hidráulica.',
  'Chirrido agudo al accionar el freno de mano.',
  'B',
  'El desbalanceo por distribución irregular de masas en el conjunto llanta-rin genera fuerzas centrífugas que se traducen en molestas y peligrosas vibraciones.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Alineación y Balanceo',
  'ANSV 2026',
  NULL
),

-- 203. [GENERAL] Extintor de Incendios en el Vehículo
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  'Respecto al extintor de incendios incluido en el kit de carretera, la norma exige que este deba estar:',
  'Guardado en el fondo del baúl bajo la llanta de repuesto.',
  'Cargado, con fecha de vencimiento vigente, manómetro en zona verde y ubicado en un lugar de fácil acceso.',
  'Descargado para evitar explosiones por calor.',
  'Sujeto con candado al chasís del vehículo.',
  'B',
  'El extintor debe estar listo para uso inmediato frente a una amago de incendio, con su carga y presión verificadas mediante la aguja del indicador.',
  'Código Nacional de Tránsito',
  'Artículo 30 - Extintores Reglamentarios',
  'Ley 769 de 2002',
  NULL
),

-- 204. [GENERAL] Tipo de Extintor según Normativa
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué tipo de agente extintor es el recomendado para combatir los fuegos que potencialmente se presentan en vehículos (Líquidos inflamables y sistemas eléctricos)?',
  'Agua a presión únicamente.',
  'Polvo Químico Seco (BC o ABC) o Solkaflam acordes al tipo de combustible y circuitos.',
  'Espuma vegetal sin certificación.',
  'Dióxido de carbono comprimido en estado líquido.',
  'B',
  'Los extintores tipo ABC o BC atacan eficazmente el fuego originado por gasolina, aceites o cortocircuitos eléctricos sin conducir corriente.',
  'Manual de Referencia ANSV y CNT',
  'Módulo 4 - Elementos de Prevención',
  'ANSV 2026',
  NULL
),

-- 205. [GENERAL] Botiquín de Primeros Auxilios Obligatorio
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Cuál de los siguientes insumos es indispensable dentro del botiquín de primeros auxilios exigido en el kit de carretera?',
  'Antibióticos e inyectables de uso especializado.',
  'Antisépticos, gasas estériles, venda elástica, algodón, venda de algodón y tijeras.',
  'Bisturí de cirugía mayor.',
  'Pastillas para el dolor de cabeza exclusivamente.',
  'B',
  'El botiquín reglamentario busca proveer elementos de curación básica e inmovilización primaria para contener hemorragias antes de la llegada de paramédicos.',
  'Código Nacional de Tránsito',
  'Artículo 30 - Botiquín de Auxilios',
  'Ley 769 de 2002',
  NULL
),

-- 206. [GENERAL] Estado de la Llanta de Repuesto
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'vehicle',
  '¿Qué requisito de mantenimiento debe cumplir la llanta de repuesto portada en el vehículo?',
  'Tener menor tamaño que las llantas principales.',
  'Mantener la presión de aire adecuada y la profundidad de labrado reglamentaria para ser usada en cualquier instante.',
  'Estar desinflada para ahorrar espacio.',
  'Ser de un rin diferente al homologado por el fabricante.',
  'B',
  'Una llanta de repuesto desinflada o lisa resulta inútil ante un pinchazo en carretera. Debe inspeccionarse con la misma regularidad que las demás.',
  'Manual de Referencia ANSV',
  'Módulo 4 - Llantas y Seguridad',
  'ANSV 2026',
  NULL
),

-- 207. [GENERAL] Definición de Punto Ciego o Ciego Visual
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  '¿Qué se entiende por "punto ciego" en el contexto de la conducción de vehículos?',
  'Una zona del camino donde no hay alumbrado público.',
  'Las áreas alrededor del vehículo que no pueden ser observadas por el conductor a través de los espejos retrovisores ni de la visión directa.',
  'El instante en que el conductor parpadea.',
  'La sombra proyectada por un árbol sobre la calzada.',
  'B',
  'Los puntos ciegos son ángulos ocluidos por la carrocería o el diseño de espejos. Para neutralizarlos se requiere girar levemente la cabeza o instalar espejos convexos.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Ergonomía y Espejos',
  'ANSV 2026',
  '/assets/images/illustrations/puntos_ciegos_vehiculo.png'
),

-- 208. [GENERAL] Puntos Ciegos en Vehículos Pesados
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Comparados con los automóviles particulares, los puntos ciegos en tractocamiones, buses y camiones de gran tonelaje son:',
  'Mucho menores debido a la altura de la cabina.',
  'Significativamente más amplios y peligrosos en los cuatro costados del vehículo.',
  'Inexistentes por contar con múltiples espejos.',
  'Iguales en todas sus dimensiones.',
  'B',
  'Los vehículos pesados poseen "puntos ciegos" gigantescos, especialmente en la parte trasera, costado derecho y debajo de la cabina. Si no ves sus espejos, ellos no te ven.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Interacción con Vehículos Pesados',
  'ANSV 2026',
  '/assets/images/illustrations/puntos_ciegos_camion.png'
),

-- 209. [GENERAL] Uso de Pantallas o GPS durante la Marcha
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Para programar una ruta en el navegador GPS o aplicación de mapas mientras se conduce, la acción correcta es:',
  'Digitar la dirección con una mano mientras se sostiene el volante con la otra.',
  'Programar la ruta antes de iniciar el viaje o detener el vehículo en un lugar permitido para ajustarla.',
  'Pedirle a un peatón que la digite en un semáforo.',
  'Mirar fijamente la pantalla mientras se avanza despacio.',
  'B',
  'Manipular pantallas al conducir genera distracción cognitiva, visual y manual. Toda configuración debe hacerse con el automotor totalmente estacionado.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Distractores Tecnológicos',
  'ANSV 2026',
  NULL
),

-- 210. [GENERAL] Conducción Agresiva e Ira al Volante
(
  array['A2', 'B1', 'C1', 'GENERAL'],
  'attitudes',
  'Ante una provocación, reclamo o maniobra imprudente por parte de otro conductor en la vía, la respuesta adecuada en conducción preventiva es:',
  'Responder con la bocina e insultos para hacerse respetar.',
  'Mantener la calma, no engancharse en disputas, ceder espacio y alejarse del conductor agresivo.',
  'Cerrarle el paso al otro vehículo para obligarlo a detenerse.',
  'Acelerar para sobrepasarlo a alta velocidad.',
  'B',
  'La violencia vial o ira al volante escala rápidamente en siniestros o agresiones. La postura preventiva prioriza la seguridad y la desescalada del conflicto.',
  'Manual de Referencia ANSV',
  'Módulo 1 - Inteligencia Emocional Vial',
  'ANSV 2026',
  NULL
);
