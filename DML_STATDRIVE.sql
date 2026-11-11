-- SCRIPT DML POBLACION DE LA BASE
-- se pasaron los datos desde el libro de excel usando IA

-- ============================================================
-- SCRIPT DML - POBLADO DE LA BASE StatDriveDB
-- PROYECTO STAT-DRIVE (Probabilidad y Estadística)
-- Fuente: Trayectos_proyecto_proba.xlsx (hojas: Leila, Christian, Mangandi, Danny, Jose)
-- Ejecutar UNA sola vez sobre las tablas vacías (después del script DDL).
-- ============================================================

USE StatDriveDB;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

-- ------------------------------------------------------------
-- 1) ESTUDIANTES
-- SUPUESTO: Leila y Mangandi no tienen recargas de combustible en el libro,
-- por eso se registraron como 'Transporte publico'. Si no es así, corregir con:
--   UPDATE estudiantes SET medio_transporte_habitual = 'Vehículo Propio' WHERE nombre = 'Leila';
-- ------------------------------------------------------------
INSERT INTO estudiantes (nombre, medio_transporte_habitual) VALUES
    (N'Leila', N'Transporte publico'),
    (N'Christian', N'Vehículo Propio'),
    (N'Mangandi', N'Transporte publico'),
    (N'Danny', N'Vehículo Propio'),
    (N'Jose', N'Vehículo Propio');

-- ------------------------------------------------------------
-- 2) TRAYECTOS (tipo_trayecto es columna calculada: no se inserta)
-- Se obtiene id_estudiante por nombre; los id_trayecto se generan solos.
-- ------------------------------------------------------------
-- Trayectos de Leila (31 filas)
INSERT INTO trayectos (id_estudiante, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
SELECT e.id_estudiante, CAST(v.fecha_hora AS DATETIME), v.origen_destino, v.distancia_km, v.tiempo_minutos
FROM (VALUES
    (N'Leila', '2026-10-13T05:40:00', N'Casa - UCA', 9.6, 32),
    (N'Leila', '2026-10-13T17:15:00', N'UCA - Casa', 9.6, 45),
    (N'Leila', '2026-10-14T06:00:00', N'Casa - UCA', 9.6, 40),
    (N'Leila', '2026-10-14T15:15:00', N'UCA - Metrocentro', 4.8, 20),
    (N'Leila', '2026-10-14T16:37:00', N'Metrocentro - Casa', 6.5, 45),
    (N'Leila', '2026-10-15T07:30:00', N'Casa - UCA', 9.6, 40),
    (N'Leila', '2026-10-15T18:35:00', N'UCA - Casa', 9.6, 29),
    (N'Leila', '2026-10-16T05:25:00', N'Casa - UCA', 9.6, 20),
    (N'Leila', '2026-10-16T17:41:00', N'UCA - Casa', 9.6, 41),
    (N'Leila', '2026-10-17T15:40:00', N'UCA - Casa', 9.6, 26),
    (N'Leila', '2026-10-18T07:00:00', N'Casa - Iglesia Bautista Miramonte', 3.6, 15),
    (N'Leila', '2026-10-18T09:55:00', N'Iglesia Bautista Miramonte - Casa', 3.6, 17),
    (N'Leila', '2026-10-19T06:11:00', N'Casa - UCA', 9.6, 68),
    (N'Leila', '2026-10-19T19:12:00', N'UCA - Casa', 9.6, 40),
    (N'Leila', '2026-10-20T06:31:00', N'Casa - UCA', 9.6, 49),
    (N'Leila', '2026-10-20T18:20:00', N'UCA - Casa', 9.6, 39),
    (N'Leila', '2026-10-21T05:47:00', N'Casa - Mercado central', 3.9, 13),
    (N'Leila', '2026-10-21T06:00:00', N'Mercado Central - UCA', 5.5, 26),
    (N'Leila', '2026-10-21T15:06:00', N'UCA - Iglesia Bautista Miramonte', 5.3, 71),
    (N'Leila', '2026-10-21T16:15:00', N'Iglesia Bautista Miramonte - Casa', 3.6, 25),  -- Corregido: en el libro la fecha decía 2010
    (N'Leila', '2026-10-22T06:54:00', N'Casa - UCA', 9.6, 51),
    (N'Leila', '2026-10-22T17:47:00', N'UCA - Casa', 9.6, 25),
    (N'Leila', '2026-10-23T06:30:00', N'Casa - UCA', 9.6, 48),
    (N'Leila', '2026-10-23T17:27:00', N'UCA - Casa', 9.6, 28),
    (N'Leila', '2026-10-24T08:33:00', N'Casa - UCA', 9.6, 26),
    (N'Leila', '2026-10-24T15:27:00', N'UCA - Iglesia Bautista Miramonte', 5.3, 14),
    (N'Leila', '2026-10-24T18:43:00', N'Iglesia Bautista Miramonte - Casa', 3.6, 23),
    (N'Leila', '2026-10-26T06:15:00', N'Casa - UCA', 9.6, 40),
    (N'Leila', '2026-10-26T19:00:00', N'UCA - Casa', 9.6, 32),
    (N'Leila', '2026-10-27T05:20:00', N'Casa - UCA', 9.6, 22),
    (N'Leila', '2026-10-27T18:27:00', N'UCA - Casa', 9.6, 38)
) AS v (nombre, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
JOIN estudiantes e ON e.nombre = v.nombre
ORDER BY v.fecha_hora;

-- Trayectos de Christian (26 filas)
INSERT INTO trayectos (id_estudiante, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
SELECT e.id_estudiante, CAST(v.fecha_hora AS DATETIME), v.origen_destino, v.distancia_km, v.tiempo_minutos
FROM (VALUES
    (N'Christian', '2026-10-14T08:23:00', N'Casa - UCA', 14.1, 42),
    (N'Christian', '2026-10-14T19:53:00', N'UCA - Casa', 14.1, 30),
    (N'Christian', '2026-10-15T07:43:00', N'Casa - UCA', 14.1, 44),
    (N'Christian', '2026-10-15T20:25:00', N'UCA - Casa', 14.1, 24),
    (N'Christian', '2026-10-18T11:05:00', N'Pricesmart Antiguo Cuscatlán - Casa', 15.9, 23),
    (N'Christian', '2026-10-19T09:46:00', N'Casa - UCA', 14.1, 22),
    (N'Christian', '2026-10-19T19:21:00', N'UCA - Casa', 14.1, 33),
    (N'Christian', '2026-10-20T08:52:00', N'Casa - UCA', 14.1, 44),
    (N'Christian', '2026-10-20T20:09:00', N'UCA - Casa', 14.1, 23),
    (N'Christian', '2026-10-21T09:23:00', N'Casa - UCA', 14.1, 24),
    (N'Christian', '2026-10-21T19:32:00', N'UCA - Casa', 14.1, 23),
    (N'Christian', '2026-10-22T08:09:00', N'Casa - UCA', 14.1, 48),
    (N'Christian', '2026-10-22T20:14:00', N'UCA - Casa', 14.1, 21),
    (N'Christian', '2026-10-24T09:12:00', N'Casa - UCA', 14.1, 26),
    (N'Christian', '2026-10-24T12:20:00', N'UCA - Casa', 14.1, 21),
    (N'Christian', '2026-10-26T09:25:00', N'Casa - UCA', 14.1, 21),
    (N'Christian', '2026-10-26T18:41:00', N'UCA - Casa', 14.1, 29),
    (N'Christian', '2026-10-27T05:29:00', N'Casa - UCA', 14.1, 64),
    (N'Christian', '2026-10-27T20:16:00', N'UCA - Casa', 14.1, 45),
    (N'Christian', '2026-10-28T09:40:00', N'Casa - C.C. Las Cascadas', 14.6, 41),
    (N'Christian', '2026-10-28T10:37:00', N'C.C. Las Cascadas - UCA', 3.5, 13),
    (N'Christian', '2026-10-28T17:52:00', N'UCA - Casa', 14.1, 68),
    (N'Christian', '2026-10-29T07:30:00', N'Casa - UCA', 14.1, 92),
    (N'Christian', '2026-10-29T19:38:00', N'UCA - Casa', 14.1, 24),
    (N'Christian', '2026-10-30T08:30:00', N'Casa - UCA', 14.1, 90),
    (N'Christian', '2026-10-30T17:11:00', N'UCA - Casa', 14.1, 70)
) AS v (nombre, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
JOIN estudiantes e ON e.nombre = v.nombre
ORDER BY v.fecha_hora;

-- Trayectos de Mangandi (43 filas)
INSERT INTO trayectos (id_estudiante, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
SELECT e.id_estudiante, CAST(v.fecha_hora AS DATETIME), v.origen_destino, v.distancia_km, v.tiempo_minutos
FROM (VALUES
    (N'Mangandi', '2026-10-13T07:35:00', N'Casa - UCA', 20, 80),
    (N'Mangandi', '2026-10-13T15:04:00', N'Basílica - Casa', 18, 66),
    (N'Mangandi', '2026-10-14T07:46:00', N'Casa - UCA', 18, 62),
    (N'Mangandi', '2026-10-14T11:07:00', N'UCA - Casa', 18, 66),
    (N'Mangandi', '2026-10-15T06:18:00', N'Casa - UCA', 15, 80),
    (N'Mangandi', '2026-10-15T03:58:00', N'Basílica - Casa', 19, 82),  -- OJO: 03:58 en el libro; posible 15:58 (revisar)
    (N'Mangandi', '2026-10-16T07:39:00', N'Casa - UCA', 19, 64),
    (N'Mangandi', '2026-10-16T13:40:00', N'Basílica - Uno Lourdes', 15, 51),
    (N'Mangandi', '2026-10-17T09:21:00', N'Casa - UCA', 20, 66),
    (N'Mangandi', '2026-10-17T13:19:00', N'UCA - Casino Emperatriz', 5.3, 14),
    (N'Mangandi', '2026-10-17T15:22:00', N'Casino Emperatriz - Casa', 16, 53),
    (N'Mangandi', '2026-10-18T09:37:00', N'Casa - Accesorios Criss Flor Blanca', 20.8, 38),
    (N'Mangandi', '2026-10-18T11:01:00', N'Accesorios Criss Flor Blanca - Plaza Gerardo Barrios', 3.2, 26),
    (N'Mangandi', '2026-10-18T14:53:00', N'Plaza Gerardo Barrios - Multiplaza', 7.4, 21),
    (N'Mangandi', '2026-10-18T16:39:00', N'Multiplaza - Casa', 15, 38),
    (N'Mangandi', '2026-10-19T08:02:00', N'Casa - UCA', 18, 74),
    (N'Mangandi', '2026-10-19T15:43:00', N'UCA - Basílica', 0.8, 16),
    (N'Mangandi', '2026-10-19T16:21:00', N'Basílica - Casa', 17, 100),
    (N'Mangandi', '2026-10-20T09:32:00', N'Casa - Visita desconocida', 18, 58),
    (N'Mangandi', '2026-10-20T15:32:00', N'Visita desconocida - Basílica', 0.65, 17),
    (N'Mangandi', '2026-10-20T15:56:00', N'Basílica - Casa', 19, 84),
    (N'Mangandi', '2026-10-21T07:44:00', N'Casa - UCA', 17, 53),
    (N'Mangandi', '2026-10-21T14:50:00', N'UCA - Casa', 17, 62),
    (N'Mangandi', '2026-10-22T08:11:00', N'Casa - Basílica', 18, 60),
    (N'Mangandi', '2026-10-22T15:48:00', N'Basílica - Casa', 14, 107),
    (N'Mangandi', '2026-10-23T07:26:00', N'Casa - UCA', 17, 49),
    (N'Mangandi', '2026-10-23T16:16:00', N'UCA - PIP''s Carymar', 6.1, 37),
    (N'Mangandi', '2026-10-23T17:01:00', N'PIP''s Carymar - Casa', 11, 49),
    (N'Mangandi', '2026-10-24T09:09:00', N'Casa - Fondo Social para la Vivienda', 23.2, 110),
    (N'Mangandi', '2026-10-24T11:15:00', N'Fondo Social para la Vivienda - El Rosal', 2.3, 8),
    (N'Mangandi', '2026-10-24T12:34:00', N'Plaza Salvador del Mundo - Casa', 21, 113),
    (N'Mangandi', '2026-10-26T08:02:00', N'Casa - Parque Daniel Hernández', 11, 44),
    (N'Mangandi', '2026-10-26T09:04:00', N'Parque Daniel Hernández - UCA', 6.1, 33),
    (N'Mangandi', '2026-10-26T17:03:00', N'Basílica - Casa', 16, 81),
    (N'Mangandi', '2026-10-27T15:41:00', N'Basílica - Casa', 18, 70),
    (N'Mangandi', '2026-10-28T08:31:00', N'Casa - UCA', 19.2, 83),
    (N'Mangandi', '2026-10-28T16:17:00', N'UCA - Casa', 16, 37),
    (N'Mangandi', '2026-10-28T18:24:00', N'Casa - Tienda (Carr. Los Naranjos)', 5.7, 20),
    (N'Mangandi', '2026-10-28T19:25:00', N'Tienda - Ceviche''s', 2.3, 11),
    (N'Mangandi', '2026-10-28T20:24:00', N'Ceviche''s - Parque Nvo Poniente', 0.2, 1),
    (N'Mangandi', '2026-10-28T20:51:00', N'Parque Nvo Poniente - Casa', 2.8, 10),
    (N'Mangandi', '2026-10-29T08:56:00', N'Casa - Basílica', 17, 72),
    (N'Mangandi', '2026-10-29T15:51:00', N'UCA - Casa', 15.3, 44)
) AS v (nombre, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
JOIN estudiantes e ON e.nombre = v.nombre
ORDER BY v.fecha_hora;

-- Trayectos de Danny (21 filas)
INSERT INTO trayectos (id_estudiante, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
SELECT e.id_estudiante, CAST(v.fecha_hora AS DATETIME), v.origen_destino, v.distancia_km, v.tiempo_minutos
FROM (VALUES
    (N'Danny', '2026-10-13T18:30:00', N'UCA - Casa', 22, 90),
    (N'Danny', '2026-10-14T15:30:00', N'Casa - UCA', 22, 45),
    (N'Danny', '2026-10-14T19:30:00', N'UCA - Casa', 22, 46),
    (N'Danny', '2026-10-15T06:02:00', N'Casa - UCA', 22, 56),
    (N'Danny', '2026-10-15T18:50:00', N'UCA - Casa', 22, 77),
    (N'Danny', '2026-10-17T06:30:00', N'Casa - UCA', 22, 45),
    (N'Danny', '2026-10-17T12:30:00', N'UCA - Casa', 22, 58),
    (N'Danny', '2026-10-19T16:01:00', N'Casa - UCA', 22, 49),
    (N'Danny', '2026-10-19T20:20:00', N'UCA - Casa', 22, 70),
    (N'Danny', '2026-10-20T06:06:00', N'Casa - UCA', 22, 57),
    (N'Danny', '2026-10-20T19:17:00', N'UCA - Casa', 22, 51),
    (N'Danny', '2026-10-22T06:07:00', N'Casa - UCA', 22, 51),
    (N'Danny', '2026-10-22T12:00:00', N'UCA - Casa', 22, 70),
    (N'Danny', '2026-10-24T07:02:00', N'Casa - UCA', 22, 33),
    (N'Danny', '2026-10-24T12:17:00', N'UCA - Casa', 22, 64),
    (N'Danny', '2026-10-25T09:42:00', N'Casa - San Martín', 55, 86),
    (N'Danny', '2026-10-25T16:25:00', N'San Martín - Casa', 55, 55),
    (N'Danny', '2026-10-26T16:18:00', N'Casa - UCA', 22, 69),
    (N'Danny', '2026-10-26T19:58:00', N'UCA - Casa', 22, 40),
    (N'Danny', '2026-10-27T05:34:00', N'Casa - UCA', 22, 48),
    (N'Danny', '2026-10-27T19:38:00', N'UCA - Casa', 22, 54)
) AS v (nombre, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
JOIN estudiantes e ON e.nombre = v.nombre
ORDER BY v.fecha_hora;

-- Trayectos de Jose (22 filas)
INSERT INTO trayectos (id_estudiante, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
SELECT e.id_estudiante, CAST(v.fecha_hora AS DATETIME), v.origen_destino, v.distancia_km, v.tiempo_minutos
FROM (VALUES
    (N'Jose', '2026-10-14T05:42:00', N'Casa - UCA', 18.5, 58.2),
    (N'Jose', '2026-10-14T16:40:00', N'UCA - Casa', 16.9, 15),
    (N'Jose', '2026-10-15T05:43:00', N'Casa - UCA', 18.5, 61.8),
    (N'Jose', '2026-10-15T16:42:00', N'UCA - Casa', 16.9, 81),
    (N'Jose', '2026-10-16T05:48:00', N'Casa - UCA', 18.6, 73.8),
    (N'Jose', '2026-10-16T13:20:00', N'UCA - Casa', 16.9, 22.8),
    (N'Jose', '2026-10-17T15:24:00', N'Casa - Compras', 17.2, 40.2),
    (N'Jose', '2026-10-17T17:35:00', N'Compras - Casa', 17.5, 88.2),
    (N'Jose', '2026-10-19T05:40:00', N'Casa - UCA', 18.5, 58.2),
    (N'Jose', '2026-10-19T16:42:00', N'UCA - Casa', 16.8, 70.2),
    (N'Jose', '2026-10-20T05:43:00', N'Casa - UCA', 18.5, 105),
    (N'Jose', '2026-10-20T16:55:00', N'UCA - Casa', 16.8, 75),
    (N'Jose', '2026-10-21T05:45:00', N'Casa - UCA', 18.6, 66),
    (N'Jose', '2026-10-21T16:45:00', N'UCA - Casa', 16.9, 72),
    (N'Jose', '2026-10-22T05:42:00', N'Casa - UCA', 18.5, 64.2),
    (N'Jose', '2026-10-22T17:00:00', N'UCA - Casa', 16.9, 64.8),
    (N'Jose', '2026-10-23T06:00:00', N'Casa - UCA', 18.5, 72),
    (N'Jose', '2026-10-23T13:30:00', N'UCA - Casa', 16.9, 19.8),
    (N'Jose', '2026-10-24T16:00:00', N'Casa - Compras', 17.2, 37.2),
    (N'Jose', '2026-10-24T18:00:00', N'Compras - Casa', 17.6, 81),
    (N'Jose', '2026-10-26T05:42:00', N'Casa - UCA', 18.5, 58.2),
    (N'Jose', '2026-10-26T16:45:00', N'UCA - Casa', 16.9, 72)
) AS v (nombre, fecha_hora, origen_destino, distancia_km, tiempo_minutos)
JOIN estudiantes e ON e.nombre = v.nombre
ORDER BY v.fecha_hora;

-- ------------------------------------------------------------
-- 3) INCIDENCIAS
-- Solo se crean filas donde el libro registra un incidente (se omiten 'nada',
-- 'Sin incidentes', 'Tráfico normal', etc.). Si una celda lista varios incidentes,
-- cada uno es una fila con id_incidencia 1, 2, 3... dentro de su trayecto.
-- El trayecto se ubica por estudiante + fecha_hora + origen_destino.
-- ------------------------------------------------------------
INSERT INTO incidencias (id_trayecto, id_incidencia, descripcion_incidencia)
SELECT t.id_trayecto, v.id_incidencia, v.descripcion_incidencia
FROM (VALUES
    -- Leila
    (N'Leila', '2026-10-13T05:40:00', N'Casa - UCA', 1, N'Tráfico sobre los Procéres'),
    (N'Leila', '2026-10-14T16:37:00', N'Metrocentro - Casa', 1, N'Tráfico en Alameda Juan Pablo II'),
    (N'Leila', '2026-10-15T07:30:00', N'Casa - UCA', 1, N'Accidente sobre Blvd. Venezuela'),
    (N'Leila', '2026-10-16T17:41:00', N'UCA - Casa', 1, N'Lluvia'),
    (N'Leila', '2026-10-17T15:40:00', N'UCA - Casa', 1, N'Lluvia'),
    (N'Leila', '2026-10-19T06:11:00', N'Casa - UCA', 1, N'Choque en el Blvd. Del Ejército'),
    (N'Leila', '2026-10-19T06:11:00', N'Casa - UCA', 2, N'Tráfico en los Procéres'),
    (N'Leila', '2026-10-20T18:20:00', N'UCA - Casa', 1, N'Tráfico en los Procéres'),
    (N'Leila', '2026-10-20T18:20:00', N'UCA - Casa', 2, N'Tráfico en Blvd. Venezuela'),
    (N'Leila', '2026-10-21T15:06:00', N'UCA - Iglesia Bautista Miramonte', 1, N'Camión chocado en Los Procéres, calle cerrada'),
    (N'Leila', '2026-10-22T06:54:00', N'Casa - UCA', 1, N'Tráfico sobre los Procéres'),
    (N'Leila', '2026-10-23T06:30:00', N'Casa - UCA', 1, N'Tráfico por el Hermano Lejano'),
    (N'Leila', '2026-10-26T19:00:00', N'UCA - Casa', 1, N'Tráfico en los Procéres'),
    (N'Leila', '2026-10-27T18:27:00', N'UCA - Casa', 1, N'Tráfico sobre Calle de Monserrat'),
    -- Christian
    (N'Christian', '2026-10-14T08:23:00', N'Casa - UCA', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-15T07:43:00', N'Casa - UCA', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-18T11:05:00', N'Pricesmart Antiguo Cuscatlán - Casa', 1, N'Accidente Redondel Paso del Jaguar'),
    (N'Christian', '2026-10-20T08:52:00', N'Casa - UCA', 1, N'Accidente Redondel Paso del Jaguar'),
    (N'Christian', '2026-10-22T08:09:00', N'Casa - UCA', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-26T18:41:00', N'UCA - Casa', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-27T05:29:00', N'Casa - UCA', 1, N'Auto quedado Redondel Paso del Jaguar'),
    (N'Christian', '2026-10-28T17:52:00', N'UCA - Casa', 1, N'Tráfico sobre Los Próceres'),
    (N'Christian', '2026-10-29T07:30:00', N'Casa - UCA', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-29T07:30:00', N'Casa - UCA', 2, N'Tráfico sobre Los Procéres'),
    (N'Christian', '2026-10-30T08:30:00', N'Casa - UCA', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-30T08:30:00', N'Casa - UCA', 2, N'Tráfico sobre Los Procéres'),
    (N'Christian', '2026-10-30T17:11:00', N'UCA - Casa', 1, N'Tráfico sobre Autopista a Comalapa'),
    (N'Christian', '2026-10-30T17:11:00', N'UCA - Casa', 2, N'Tráfico sobre Los Procéres'),
    -- Mangandi
    (N'Mangandi', '2026-10-13T15:04:00', N'Basílica - Casa', 1, N'Lluvias y tormentas por la tarde'),
    (N'Mangandi', '2026-10-15T03:58:00', N'Basílica - Casa', 1, N'Tráfico pesado'),
    (N'Mangandi', '2026-10-15T03:58:00', N'Basílica - Casa', 2, N'Lluvias y tormentas por la tarde y noche'),
    (N'Mangandi', '2026-10-16T13:40:00', N'Basílica - Uno Lourdes', 1, N'Lluvias, tormentas y ráfagas de viento por la tarde'),
    (N'Mangandi', '2026-10-19T15:43:00', N'UCA - Basílica', 1, N'Lluvias y tormentas por la tarde'),
    (N'Mangandi', '2026-10-19T16:21:00', N'Basílica - Casa', 1, N'Tráfico pesado'),
    (N'Mangandi', '2026-10-19T16:21:00', N'Basílica - Casa', 2, N'Lluvias y tormentas por la tarde'),
    (N'Mangandi', '2026-10-20T15:32:00', N'Visita desconocida - Basílica', 1, N'Lluvias y tormentas dispersas por la tarde'),
    (N'Mangandi', '2026-10-20T15:56:00', N'Basílica - Casa', 1, N'Tráfico pesado'),
    (N'Mangandi', '2026-10-20T15:56:00', N'Basílica - Casa', 2, N'Lluvias y tormentas dispersas por la tarde'),
    (N'Mangandi', '2026-10-21T14:50:00', N'UCA - Casa', 1, N'Lluvias y tormentas por la tarde (pronóstico MARN)'),
    (N'Mangandi', '2026-10-21T14:50:00', N'UCA - Casa', 2, N'Camión chocó contra un poste en el bulevar Los Próceres esa tarde'),
    (N'Mangandi', '2026-10-22T15:48:00', N'Basílica - Casa', 1, N'Tráfico pesado'),
    (N'Mangandi', '2026-10-24T12:34:00', N'Plaza Salvador del Mundo - Casa', 1, N'Tráfico pesado'),
    (N'Mangandi', '2026-10-26T17:03:00', N'Basílica - Casa', 1, N'Tráfico pesado'),
    -- Danny
    (N'Danny', '2026-10-13T18:30:00', N'UCA - Casa', 1, N'Accidente en Los Chorros'),
    (N'Danny', '2026-10-14T19:30:00', N'UCA - Casa', 1, N'Tráfico por Los Chorros'),
    (N'Danny', '2026-10-15T06:02:00', N'Casa - UCA', 1, N'Tráfico en Colón'),
    (N'Danny', '2026-10-15T18:50:00', N'UCA - Casa', 1, N'Tráfico en Los Chorros'),
    (N'Danny', '2026-10-17T12:30:00', N'UCA - Casa', 1, N'Tráfico en el Árbol de la Paz por una pelea entre dos personas (post parcial de Probabilidad)'),
    (N'Danny', '2026-10-19T16:01:00', N'Casa - UCA', 1, N'Lluvia en la carretera (llegada real 4:58 PM; estimado Waze 4:50 PM)'),
    (N'Danny', '2026-10-19T20:20:00', N'UCA - Casa', 1, N'Lluvia en el camino'),
    (N'Danny', '2026-10-19T20:20:00', N'UCA - Casa', 2, N'Tráfico en Los Chorros'),
    (N'Danny', '2026-10-19T20:20:00', N'UCA - Casa', 3, N'Accidente en Los Chorros'),
    (N'Danny', '2026-10-20T06:06:00', N'Casa - UCA', 1, N'Lluvia en el camino (llegada real 7:08 AM; estimada 7:03 AM)'),
    (N'Danny', '2026-10-20T19:17:00', N'UCA - Casa', 1, N'Tráfico en Los Próceres'),
    (N'Danny', '2026-10-22T12:00:00', N'UCA - Casa', 1, N'Tráfico en Los Chorros'),
    (N'Danny', '2026-10-24T12:17:00', N'UCA - Casa', 1, N'Tráfico en el Bulevar de Los Próceres por graduación y partido de fútbol'),
    (N'Danny', '2026-10-25T09:42:00', N'Casa - San Martín', 1, N'Carretera de Los Chorros cerrada al inicio y habilitada temprano; pasaron por Santa Tecla (calles cerradas) y por La Tecleña'),
    (N'Danny', '2026-10-26T16:18:00', N'Casa - UCA', 1, N'Tráfico en Los Chorros; comenzaban a poner el carril extra de bajada'),
    (N'Danny', '2026-10-27T19:38:00', N'UCA - Casa', 1, N'Tráfico en Los Chorros'),
    -- Jose
    (N'Jose', '2026-10-15T05:43:00', N'Casa - UCA', 1, N'1 auto quedado en la orilla'),
    (N'Jose', '2026-10-20T05:43:00', N'Casa - UCA', 1, N'1 choque en carretera')
) AS v (nombre, fecha_hora, origen_destino, id_incidencia, descripcion_incidencia)
JOIN estudiantes e ON e.nombre = v.nombre
JOIN trayectos t ON t.id_estudiante = e.id_estudiante
                 AND t.fecha_hora = CAST(v.fecha_hora AS DATETIME)
                 AND t.origen_destino = v.origen_destino;

-- ------------------------------------------------------------
-- 4) RECARGAS DE COMBUSTIBLE
-- monto_pagado es DECIMAL(6,2): los montos con más decimales del libro se
-- redondearon a centavos (p. ej. 50.0175 -> 50.02; 20.007 -> 20.01).
-- ------------------------------------------------------------
INSERT INTO RecargasCombustible (id_estudiante, fecha_recarga, galones, monto_pagado, precio_por_galon)
SELECT e.id_estudiante, CAST(v.fecha_recarga AS DATE), v.galones, v.monto_pagado, v.precio_por_galon
FROM (VALUES
    (N'Christian', '2026-10-18', 2.08, 10.00, 4.8),
    (N'Christian', '2026-10-21', 2.08, 10.00, 4.8),
    (N'Christian', '2026-10-27', 2.08, 10.00, 4.8),
    (N'Danny', '2026-10-15', 9, 46.17, 5.13),
    (N'Danny', '2026-10-21', 9.75, 50.02, 5.13),
    (N'Jose', '2026-10-15', 3.9, 20.01, 5.13),
    (N'Jose', '2026-10-19', 3.9, 20.01, 5.13),
    (N'Jose', '2026-10-23', 3.9, 20.01, 5.13)
) AS v (nombre, fecha_recarga, galones, monto_pagado, precio_por_galon)
JOIN estudiantes e ON e.nombre = v.nombre;

COMMIT TRANSACTION;
GO

-- ------------------------------------------------------------
-- 5) VERIFICACIÓN (conteos esperados según el libro)
-- ------------------------------------------------------------
SELECT 'estudiantes' AS tabla, COUNT(*) AS filas, 5 AS esperado FROM estudiantes
UNION ALL SELECT 'trayectos', COUNT(*), 143 FROM trayectos
UNION ALL SELECT 'incidencias', COUNT(*), 61 FROM incidencias
UNION ALL SELECT 'RecargasCombustible', COUNT(*), 8 FROM RecargasCombustible;

-- Trayectos por estudiante (esperado: Leila 31, Christian 26, Mangandi 43, Danny 21, Jose 22)
SELECT e.nombre, COUNT(*) AS trayectos,
       SUM(CASE WHEN t.tipo_trayecto = 'Académico' THEN 1 ELSE 0 END) AS academicos
FROM trayectos t JOIN estudiantes e ON e.id_estudiante = t.id_estudiante
GROUP BY e.nombre;
GO