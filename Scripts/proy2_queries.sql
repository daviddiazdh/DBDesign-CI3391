

-- Query requerida para la seccion 2
WITH solicitudes_por_mes AS (
    SELECT
        EXTRACT(YEAR FROM s."fecha") AS año,
        EXTRACT(MONTH FROM s."fecha") AS mes,
        r.pais_dom,
        COUNT(*) AS num_solicitudes
    FROM solicitud s
    JOIN solicita so ON s.numero_solicitud = so.fk_solicitud  -- Relacionamos solicitudes con la tabla intermedia
    JOIN solicitante r ON so.fk_solicitante = r.id_solicitante  -- Relacionamos solicitantes con la tabla intermedia
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