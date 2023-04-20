document.addEventListener('DOMContentLoaded', function () {
    cargarResultados();

    document.getElementById('refrescar').addEventListener('click', cargarResultados);
});

function cargarResultados() {
    fetch('/api/mostrar_encuentros.php')
        .then(response => response.json())
        .then(data => {
            let tablaResultados = document.getElementById('resultados').getElementsByTagName('tbody')[0];
            tablaResultados.innerHTML = '';

            data.forEach(encuentro => {
                let fila = tablaResultados.insertRow();

                fila.insertCell().innerText = encuentro.equipo1_nombre;
                fila.insertCell().innerText = encuentro.equipo1_goles;
                fila.insertCell().innerText = encuentro.equipo2_goles;
                fila.insertCell().innerText = encuentro.equipo2_nombre;
                fila.insertCell().innerText = encuentro.hora;
            });
        });
}
