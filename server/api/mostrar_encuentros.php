<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$servername = "db";
$username = "root";
$password = "mypassword";
$dbname = "mydatabase";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT e1.nombre AS equipo1_nombre, p.equipo1_goles, p.equipo2_goles, e2.nombre AS equipo2_nombre, p.hora
        FROM partidos p
        JOIN equipos e1 ON p.equipo1_id = e1.id
        JOIN equipos e2 ON p.equipo2_id = e2.id";
$result = $conn->query($sql);

$encuentros = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $encuentros[] = [
            'equipo1_nombre' => $row['equipo1_nombre'],
            'equipo1_goles' => $row['equipo1_goles'],
            'equipo2_goles' => $row['equipo2_goles'],
            'equipo2_nombre' => $row['equipo2_nombre'],
            'hora' => $row['hora'],
        ];
    }
}

echo json_encode($encuentros);

$conn->close();
