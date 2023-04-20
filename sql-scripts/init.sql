-- CREATE DATABASE mydatabase;

USE mydatabase;

-- Temas de encoding y charsest
ALTER DATABASE mydatabase CHARACTER SET utf8 COLLATE utf8_general_ci;
SET NAMES utf8;

-- Tabla de equipos e insert de equipos
CREATE TABLE equipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO equipos (nombre) VALUES ('ASIX 1'), ('ASIX 2'), ('DAW 1'), ('DAW 2'), ('Profes'), ('Comodín');

-- Tabla de partidos
CREATE TABLE partidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    equipo1_id INT,
    equipo1_goles INT DEFAULT NULL,
    equipo2_id INT,
    equipo2_goles INT DEFAULT NULL,
    hora DATETIME,
    FOREIGN KEY (equipo1_id) REFERENCES equipos(id),
    FOREIGN KEY (equipo2_id) REFERENCES equipos(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserts de partidos

-- Asignar a start_date  la fecha de inicio deseada
SET @start_date = '2023-04-20';
SET @start_time = TIME('16:00:00');
SET @interval_base = 15;
SET @time_interval = 0;

-- ASIX 2 vs DAW 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (2, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Profes vs DAW 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (5, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Comodín vs ASIX 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (6, 1, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- DAW 1 vs Profes
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (3, 5, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- DAW 2 vs ASIX 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (4, 2, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Profes vs ASIX 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (5, 2, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Comodín vs DAW 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (6, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 1 vs DAW 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (1, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 2 vs Comodín
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (2, 6, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- DAW 1 vs DAW 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (3, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 1 vs DAW 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (1, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Comodín vs DAW 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (6, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Profes vs ASIX 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (5, 1, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- DAW 2 vs Comodín
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (4, 6, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));