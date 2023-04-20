-- CREATE DATABASE mydatabase;

USE mydatabase;

ALTER DATABASE mydatabase CHARACTER SET utf8 COLLATE utf8_general_ci;

-- CHARACTER SET utf8
-- COLLATE utf8_general_ci
SET NAMES utf8;

CREATE TABLE equipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO equipos (nombre) VALUES ('ASIX 1'), ('ASIX 2'), ('DAW 1'), ('DAW 2'), ('Profes'), ('Comodín');

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

-- Añade aquí los INSERT para los partidos, por ejemplo:
-- INSERT INTO partidos (equipo1_id, equipo2_id, hora) VALUES (1, 2, '2023-04-20 16:00:00');

INSERT INTO partidos (equipo1_id, equipo1_goles, equipo2_id, equipo2_goles, hora)
VALUES (
    (SELECT id FROM equipos WHERE nombre = 'ASIX 1'),
    1,
    (SELECT id FROM equipos WHERE nombre = 'ASIX 2'),
    2,
    '2023-04-20 16:00:00'
);
