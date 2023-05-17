-- Script de arranque para 5 equipos (sólo ida);

USE mydatabase;

-- Temas de encoding y charsest
ALTER DATABASE mydatabase CHARACTER SET utf8 COLLATE utf8_general_ci;
SET NAMES utf8;

-- Tabla de equipos e insert de equipos
CREATE TABLE equipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO equipos (nombre) VALUES ('ASIX 1'), ('ASIX 2'), ('DAW 1'), ('Profes'), ('Extra');

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

ALTER TABLE `partidos` ADD `jugado` INT(1) NOT NULL DEFAULT '0' AFTER `hora`;

-- Inserts de partidos

-- Asignar a start_date  la fecha de inicio deseada
SET @start_date = '2023-05-18';
SET @start_time = TIME('17:00:00');
SET @interval_base = 20;
SET @time_interval = 0;

-- ASIX 2 vs DAW 1
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (2, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 1 vs Profes
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (1, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Extra vs ASIX 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (5, 2, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- EXTRA  vs Profes
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (5, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 1 vs DAW 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (1, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 2 vs Profes
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (2, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- DAW 1 vs Profes
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (3, 4, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Asix 1 vs Extra
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (1, 5, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- Extra vs DAW 1
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora) 
VALUES (5, 3, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

-- ASIX 1 vs ASIX 2
SET @time_interval = @time_interval + @interval_base;
INSERT INTO partidos (equipo1_id, equipo2_id, hora)
VALUES (1, 2, TIMESTAMP(@start_date, ADDTIME(@start_time, SEC_TO_TIME(@time_interval * 60))));

