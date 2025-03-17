-- Query requerida para la seccion 1

-- **********************************************************************************************************
-- Consulta: Por mes, presenta el total de marcas solicitadas por tipo de signo (denominativo, gráfico, mixto).
-- Descripción: Esta consulta presenta el total de marcas solicitadas según si su tipo es denominativo, gráfico o mixto, 
-- los agrupa por mes.
-- Autor: David Díaz
-- Fecha: 16/03/2025
-- Base de datos: Sistema de gestión de marcas del SAPI
-- ***********************************************************************************************************

SELECT 
    TO_CHAR(s.fecha, 'Mon-YYYY') AS "Mes",
    SUM(CASE WHEN sig.tipo = 'denominativa' THEN 1 ELSE 0 END) AS "Cantidad signo denominativo",
    SUM(CASE WHEN sig.tipo = 'grafica' THEN 1 ELSE 0 END) AS "Cantidad signo gráfico",
    SUM(CASE WHEN sig.tipo = 'mixta' THEN 1 ELSE 0 END) AS "Cantidad signo mixto"
FROM solicitud s
JOIN signo sig ON sig.marca = s.marca
GROUP BY TO_CHAR(s.fecha, 'Mon-YYYY')
ORDER BY MIN(TO_DATE(TO_CHAR(s.fecha, 'Mon-YYYY'), 'Mon-YYYY')) ASC;

-- Explicación
-- - Se usa TO_CHAR(s.fecha, 'Mon-YYYY') para convertir la fecha al formato requerido
-- - Se usa las funciones SUM() para sumar uno en caso de que sea del tipo requerido, de allí que se use
--   un CASE WHEN precisamente  verificando de qué tipo es para saber exactamente a qué columna sumar
-- - Fue necesario hacer el JOIN de signo para incluir el tipo del signo
-- - Se agrupo por mes y año usando TO_CHAR(s.fecha, 'Mon-YYYY')
-- - También se requería la función MIN() en el ORDER BY por el hecho de que estamos usando GROUP BY que fuerza 
--   a los ORDER BY a ser funciones de agregación.
-- - Se ordena según el mes y el año de manera ascendente
-- - Note que se usa TO_DATE(TO_CHAR(s.fecha, 'Mon-YYYY'), 'Mon-YYYY') para devolver la columna a tipo fecha

-- Query requerida para la seccion 2
WITH solicitudes_por_mes AS (
    SELECT
        EXTRACT(YEAR FROM s."fecha") AS año,
        EXTRACT(MONTH FROM s."fecha") AS mes,
        r.pais_dom,
        COUNT(*) AS num_solicitudes
    FROM solicitud s
    JOIN solicita so ON s.numero_solicitud = so.fk_solicitud
    JOIN solicitante r ON so.fk_solicitante = r.id_solicitante
    GROUP BY año, mes, r.pais_dom
),
ranked_solicitudes AS (
    SELECT
        año,
        mes,
        pais_dom,
        num_solicitudes,
        ROW_NUMBER() OVER (PARTITION BY año, mes ORDER BY num_solicitudes DESC) AS ranking
    FROM solicitudes_por_mes
)
SELECT
    TO_CHAR(TO_DATE(año || '-' || mes || '-01', 'YYYY-MM-DD'), 'Mon-YYYY') AS "Mes",
    MAX(CASE WHEN ranking = 1 THEN (pais_dom || ' (' || num_solicitudes || ')') END) AS "Pais Top 1",
    MAX(CASE WHEN ranking = 2 THEN (pais_dom || ' (' || num_solicitudes || ')') END) AS "Pais Top 2",
    MAX(CASE WHEN ranking = 3 THEN (pais_dom || ' (' || num_solicitudes || ')') END) AS "Pais Top 3"
FROM ranked_solicitudes
WHERE ranking <= 3
GROUP BY año, mes
ORDER BY año, mes;


-- Query requerida para la seccion 3 
SELECT
    numero_solicitud AS "Solicitud número",
    TO_CHAR(s.fecha, 'DD-mon-YYYY') AS "Solicitud fecha",
    TO_CHAR(p.fecha, 'DD-mon-YYYY') AS "PE fecha",
    p.numero_prioridad AS "PE número",
    p.fk_pais AS "PE país"
FROM solicitud s
JOIN prioriza pr ON pr.solicitud = s.numero_solicitud
JOIN prioridad_extranjera p ON p.numero_prioridad = pr.prioridad;


-- Query requerida para la seccion 4
SELECT
    numero_solicitud AS "Solicitud número",
    TO_CHAR(s.fecha, 'DD-mon-YYYY') AS "Solicitud fecha",
    TO_CHAR(p.fecha, 'DD-mon-YYYY') AS "PE fecha",
    p.numero_prioridad AS "PE número",
    p.fk_pais AS "PE país"
FROM solicitud s
JOIN prioriza pr ON pr.solicitud = s.numero_solicitud
JOIN prioridad_extranjera p ON p.numero_prioridad = pr.prioridad
WHERE p.fecha >= s.fecha
AND p.fecha IS NOT NULL
AND s.fecha IS NOT NULL;

-- Para cada par de mes y solicitante verifica si dicho solicitante no ha solicitado en dicho mes
-- solo devuelve aquellos que no hayan solicitado en el mes
SELECT 
    mes AS "Año",
    CASE 
        WHEN s.tipo = 'Persona Natural' THEN sn.nombre
        WHEN s.tipo = 'Persona Jurídica' THEN sj.razon_social
        ELSE NULL
    END AS "Solicitante",
    s.pais_dom AS "País de domicilio"
FROM (
    -- Selecciona todos los distintos meses usados en las solicitudes
    SELECT 
        DISTINCT TO_CHAR(sol.fecha, 'Mon-YYYY') AS mes
    FROM solicitante s
    JOIN solicita so ON s.id_solicitante = so.fk_solicitante
    JOIN solicitud sol ON sol.numero_solicitud = so.fk_solicitud
)
CROSS JOIN solicitante s
LEFT JOIN solicitante_natural sn ON sn.id_solicitante = s.id_solicitante AND s.tipo = 'Persona Natural' 
LEFT JOIN solicitante_juridico sj ON sj.id_solicitante = s.id_solicitante AND s.tipo = 'Persona Jurídica'
WHERE NOT EXISTS (
    SELECT 1
    FROM (
            -- Selecciona cada mes con los solicitantes que SI solicitaron en dicho mes
            SELECT 
                TO_CHAR(sol2.fecha, 'Mon-YYYY'),
                id_solicitante
            FROM solicitante s2
            JOIN solicita so2 ON s2.id_solicitante = so2.fk_solicitante
            JOIN solicitud sol2 ON sol2.numero_solicitud = so2.fk_solicitud
        ) s2
    JOIN solicita so2 ON s2.id_solicitante = so2.fk_solicitante
    JOIN solicitud sol2 ON sol2.numero_solicitud = so2.fk_solicitud
    WHERE TO_CHAR(sol2.fecha, 'Mon-YYYY') = mes
    AND s2.id_solicitante = s.id_solicitante
)
ORDER BY TO_DATE(mes, 'Mon-YYYY') ASC, "Solicitante" ASC
;