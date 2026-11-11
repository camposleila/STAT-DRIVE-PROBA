-- SCRIPT DDL CREACION DE LA BASE
-- PROYECTO PROBA

create database StatDriveDB;
go

use StatDriveDB;
go

-- tabla estudiantes
CREATE TABLE estudiantes (
    id_estudiante INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    medio_transporte_habitual VARCHAR(50) NOT NULL,
    CONSTRAINT CHK_MedioTransporte CHECK (medio_transporte_habitual IN ('Transporte publico', 'Vehículo Propio'))
);

-- tabla trayectos
CREATE TABLE trayectos (
    id_trayecto INT IDENTITY(1,1) PRIMARY KEY,
    id_estudiante INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    origen_destino VARCHAR(100) NOT NULL,
    
    -- Columna calculada automáticamente según el origen_destino
    tipo_trayecto AS (
        CASE 
            WHEN origen_destino IN ('Casa - UCA', 'UCA - Casa') THEN 'Académico'
            ELSE 'Extra'
        END
    ) PERSISTED,
    
    distancia_km DECIMAL(5,2) NOT NULL,
    tiempo_minutos DECIMAL(5,2) NOT NULL,
    
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante)
);


-- tabla incidencias
CREATE TABLE incidencias (
    id_trayecto INT NOT NULL,
    id_incidencia INT NOT NULL, -- Número secuencial del incidente dentro de ese trayecto específico (1, 2, 3...)
    descripcion_incidencia VARCHAR(255) NOT NULL, -- Ej: "Accidente", "Lluvia intensa", "Tráfico pesado"
    
    -- Definición de la Clave Primaria Compuesta
    CONSTRAINT PK_Incidencias PRIMARY KEY (id_trayecto, id_incidencia),
    
    -- Llave Foránea que conecta obligatoriamente el incidente con un trayecto existente
    CONSTRAINT FK_Incidencias_Trayectos FOREIGN KEY (id_trayecto) 
        REFERENCES trayectos(id_trayecto) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- tabla RecargasCombustible
CREATE TABLE RecargasCombustible (
    id_recarga INT IDENTITY(1,1) PRIMARY KEY,
    id_estudiante INT NOT NULL,
    fecha_recarga DATE NOT NULL,
    galones DECIMAL(6,3) NOT NULL CHECK (galones > 0),
    monto_pagado DECIMAL(6,2) NOT NULL CHECK (monto_pagado > 0),
    precio_por_galon DECIMAL(5,3) NOT NULL CHECK (precio_por_galon > 0),
    
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante)
);

