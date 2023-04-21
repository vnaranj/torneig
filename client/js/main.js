const resultadosTable = document.getElementById("resultados");
const refrescarBtn = document.getElementById("refrescar");

function actualizarTabla(resultados) {
  let tableHTML = "";
  resultados.forEach((resultado) => {
    const hora = new Date(resultado.fecha).toLocaleTimeString('es-ES', {hour: '2-digit', minute: '2-digit'});
    tableHTML += `
      <tr>
        <td>${resultado.equipoLocal}</td>
        <td>${resultado.golesLocal}</td>
        <td>${resultado.golesVisitante}</td>
        <td>${resultado.equipoVisitante}</td>
        <td>${hora}</td>
      </tr>
    `;
  });
  resultadosTable.querySelector("tbody").innerHTML = tableHTML;
}

async function obtenerResultados() {
  try {
    const response = await fetch("http://localhost:8585/partidos");
    const resultados = await response.json();
    actualizarTabla(resultados);
  } catch (error) {
    console.error(error);
  }
}

obtenerResultados();
refrescarBtn.addEventListener("click", obtenerResultados);
