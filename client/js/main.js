const backend='https://yklymko21-glorious-umbrella-qjgjq94gvqwhx9gx-80.preview.app.github.dev';

//div para poder meter el html dinámico
const resultadosDiv = document.getElementById("resultados");

//Botón para refrescar resultados
const refrescarBtn = document.getElementById("refrescar");

function actualizarDiv(resultados) {
  let divHTML = "";
  resultados.forEach((resultado) => {
    const hora = new Date(resultado.fecha).toLocaleTimeString('es-ES', {hour: '2-digit', minute: '2-digit'});
    const golesLocal = parseInt(resultado.golesLocal);
    const golesVisitante = parseInt(resultado.golesVisitante);

    divHTML += `
    <div class="col-mg-6 col-sm-12 lg-4">
    <div class="card mb-3">
      <div class="card-body">
        <div class="d-flex justify-content-around align-items-center">
          <div class="equipo">
            <p class="card-title text-center">${resultado.equipoLocal} - ${resultado.jugado}</p>
          </div>
          <div class="resultado d-flex flex-column align-items-center ${golesLocal > golesVisitante ? 'ganador' : golesLocal < golesVisitante ? 'perdedor' : 'empate'}">
            ${golesLocal}
          </div>
          <div class="resultado d-flex flex-column align-items-center ${golesLocal < golesVisitante ? 'ganador' : golesLocal > golesVisitante ? 'perdedor' : 'empate'}">
            ${golesVisitante}
          </div>
          <div class="equipo">
            <p class="card-title text-center">${resultado.equipoVisitante}</p>
          </div>
        </div>
        <p class="card-text text-center">${hora}</p>
      </div>
    </div>
  </div>
  
    `;
  });
  resultadosDiv.innerHTML = divHTML;
}

async function obtenerResultados() {
  try {
    const response = await fetch(backend+"/partidos");
    const resultados = await response.json();
    actualizarDiv(resultados);
  } catch (error) {
    console.error(error);
  }
}

obtenerResultados();
refrescarBtn.addEventListener("click", obtenerResultados);
