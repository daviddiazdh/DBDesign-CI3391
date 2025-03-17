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
        DISTINCT TO_CHAR(fecha, 'Mon-YYYY') AS mes
    FROM solicitud
)
CROSS JOIN solicitante s
LEFT JOIN solicitante_natural sn ON sn.id_solicitante = s.id_solicitante AND s.tipo = 'Persona Natural' 
LEFT JOIN solicitante_juridico sj ON sj.id_solicitante = s.id_solicitante AND s.tipo = 'Persona Jurídica'
WHERE NOT EXISTS (
    SELECT 1
    FROM (
            -- Selecciona cada mes con los solicitantes que SI solicitaron en dicho mes
            SELECT 
                TO_CHAR(sol2.fecha, 'Mon-YYYY') AS fecha,
                id_solicitante
            FROM solicitante s2
            JOIN solicita so2 ON s2.id_solicitante = so2.fk_solicitante
            JOIN solicitud sol2 ON sol2.numero_solicitud = so2.fk_solicitud
        ) s2
    WHERE fecha = mes
    AND s2.id_solicitante = s.id_solicitante
)
ORDER BY TO_DATE(mes, 'Mon-YYYY') ASC, "Solicitante" ASC 
;
