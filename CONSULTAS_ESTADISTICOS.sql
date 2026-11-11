-- consultas sql para obtener los estadísticos de manera individual

-- ============================================================
-- CONSULTAS DE ANÁLISIS - PROYECTO STAT-DRIVE
-- Base: StatDriveDB
-- Requisitos: SQL Server 2012+ (PERCENTILE_CONT) y 2017+ (STRING_AGG, solo consulta 4)
--
-- Notas generales
--  * STDEV y VAR son MUESTRALES (divisor n-1). Para poblacional: STDEVP / VARP.
--  * PERCENTILE_CONT en SQL Server es función de ventana (necesita OVER), por eso
--    la mediana se calcula en un CTE y luego se resume con MAX() al agrupar.
--  * Velocidad por viaje = distancia_km / (tiempo_minutos / 60.0)
--  * Se reportan dos velocidades promedio por estudiante:
--      - velocidad_ponderada_kmh = SUM(km) / SUM(horas)   <- recomendada
--      - velocidad_media_viajes_kmh = AVG(velocidad de cada viaje)
--    La ponderada no deja que un viaje corto y lento pese igual que uno largo.
-- ============================================================

USE StatDriveDB;
GO

-- ============================================================
-- 1) ANÁLISIS ACADÉMICO (Casa - UCA y UCA - Casa)
-- ============================================================
WITH base AS (
    SELECT  t.id_estudiante,
            e.nombre,
            t.tiempo_minutos,
            t.distancia_km,
            PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY t.tiempo_minutos)
                OVER (PARTITION BY t.id_estudiante) AS mediana_min
    FROM    trayectos t
    JOIN    estudiantes e ON e.id_estudiante = t.id_estudiante
    WHERE   t.tipo_trayecto = N'Académico'
)
SELECT  nombre,
        COUNT(*)                                                        AS total_viajes,
        CAST(AVG(tiempo_minutos)  AS DECIMAL(8,2))                      AS media,
        CAST(MAX(mediana_min)     AS DECIMAL(8,2))                      AS mediana,
        CAST(STDEV(tiempo_minutos) AS DECIMAL(8,2))                     AS desviación,
        CAST(VAR(tiempo_minutos)   AS DECIMAL(10,2))                    AS varianza,
        CAST(100.0 * STDEV(tiempo_minutos) / NULLIF(AVG(tiempo_minutos), 0)
                                   AS DECIMAL(6,2))                     AS coeficiente_variacion,
        MIN(tiempo_minutos)                                             AS 'min',
        MAX(tiempo_minutos)                                             AS 'max',
        -- CAMBIO REALIZADO: Mostramos la distancia fija del trayecto en lugar de una suma acumulada
        MAX(distancia_km)                                               AS distancia_trayecto_km,
        CAST(SUM(distancia_km) / NULLIF(SUM(tiempo_minutos) / 60.0, 0)
                                   AS DECIMAL(6,2))                     AS velocidad_ponderada_kmh
FROM    base
GROUP BY id_estudiante, nombre
ORDER BY nombre;
GO

-- ============================================================
-- 2) TRAYECTOS "EXTRA" (fuera de Casa - UCA / UCA - Casa)
--    Ordenado de mayor a menor cantidad de trayectos extra.
--    LEFT JOIN: un estudiante sin trayectos extra aparecería con n = 0.
-- ============================================================
SELECT  RANK() OVER (ORDER BY COUNT(t.id_trayecto) DESC)                AS puesto,
        e.nombre,
        COUNT(t.id_trayecto)                                            AS numero_extra,
        SUM(t.tiempo_minutos)                                           AS tiempo_total,
        CAST(AVG(t.tiempo_minutos)   AS DECIMAL(8,2))                   AS media,
        CAST(STDEV(t.tiempo_minutos) AS DECIMAL(8,2))                   AS desviacion,
        MIN(t.tiempo_minutos)                                           AS 'min',
        MAX(t.tiempo_minutos)                                           AS 'max',
        SUM(t.distancia_km)                                             AS distancia_total_km,
        CAST(SUM(t.distancia_km) / NULLIF(SUM(t.tiempo_minutos) / 60.0, 0)
                                    AS DECIMAL(6,2))                    AS velocidad_ponderada_kmh
FROM    estudiantes e
LEFT JOIN trayectos t
        ON  t.id_estudiante = e.id_estudiante
        AND t.tipo_trayecto = N'Extra'
GROUP BY e.id_estudiante, e.nombre
ORDER BY numero_extra DESC, tiempo_total DESC;
GO

-- ============================================================
-- 3) CONSOLIDADO TOTAL (Académicos + Extras) POR ESTUDIANTE
-- ============================================================
-- ============================================================
-- 3) CONSOLIDADO TOTAL - VERSIÓN SIMPLIFICADA Y LIMPIA
-- ============================================================
SELECT 
    e.nombre,
    COUNT(t.id_trayecto)                                           AS total_viajes,
    SUM(CASE WHEN t.tipo_trayecto = N'Académico' THEN 1 ELSE 0 END) AS viajes_acad,
    SUM(CASE WHEN t.tipo_trayecto = N'Extra'     THEN 1 ELSE 0 END) AS viajes_extra,
    CAST(SUM(t.tiempo_minutos) / 60.0 AS DECIMAL(6,1))             AS horas_totales_en_trafico,
    CAST(AVG(t.tiempo_minutos) AS DECIMAL(6,1))                    AS tiempo_promedio_min,
    CAST(SUM(t.distancia_km) AS DECIMAL(6,1))                      AS km_totales,
    CAST(SUM(t.distancia_km) / NULLIF(SUM(t.tiempo_minutos) / 60.0, 0) 
         AS DECIMAL(6,1))                                         AS vel_ponderada_kmh,
    SUM(CASE WHEN i.id_incidencia IS NOT NULL THEN 1 ELSE 0 END)   AS viajes_con_incidencia
FROM estudiantes e
JOIN trayectos t ON t.id_estudiante = e.id_estudiante
LEFT JOIN incidencias i ON i.id_trayecto = t.id_trayecto
GROUP BY e.id_estudiante, e.nombre
ORDER BY horas_totales_en_trafico DESC;
GO

SELECT * FROM trayectos;
GO

SELECT * FROM estudiantes; 
GO

SELECT * FROM incidencias;
GO

SELECT * FROM RecargasCombustible; 
GO