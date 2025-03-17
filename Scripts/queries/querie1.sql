-- Para cada par de mes y solicitante verifica si dicho solicitante no ha solicitado en dicho mes
-- solo devuelve aquellos que no hayan solicitado en el mes
SELECT 
    TO_CHAR(s.fecha, 'Mon-YYYY'),
    SUM(CASE WHEN sig.tipo = 'denominativa' THEN 1 ELSE 0 END),
    SUM(CASE WHEN sig.tipo = 'grafica' THEN 1 ELSE 0 END),
    SUM(CASE WHEN sig.tipo = 'mixta' THEN 1 ELSE 0 END)
FROM solicitud s
JOIN signo sig ON sig.marca = s.marca
GROUP BY TO_CHAR(s.fecha, 'Mon-YYYY')
ORDER BY MIN(TO_DATE(TO_CHAR(s.fecha, 'Mon-YYYY'), 'Mon-YYYY')) ASC;
