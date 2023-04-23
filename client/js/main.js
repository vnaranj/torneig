//div para poder meter el html dinámico
const resultadosDiv = document.getElementById("resultados");

//Botón para refrescar resultados
const refrescarBtn = document.getElementById("refrescar");

function actualizarDiv(resultados) {
  let divHTML = "";
  resultados.forEach((resultado) => {
    const hora = new Date(resultado.fecha).toLocaleTimeString('es-ES', {hour: '2-digit', minute: '2-digit'});
    const golesLocal = resultado.golesLocal;
    const golesVisitante = resultado.golesVisitante;

    divHTML += `
      <div class="col-md-3 col-sm-12 mb-4">
        <div class="card mb-3">
          <div class="card-body">
            <h5 class="card-title">${resultado.equipoLocal} vs ${resultado.equipoVisitante}</h5>
            <div class="d-flex justify-content-around">
              <div class="rounded resultado">
                <p class="goles">${golesLocal}</p>
                <p>GOLES</p>
              </div>
              <div class="rounded resultado">
                <p class="goles">${golesVisitante}</p>
                <p>GOLES</p>
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
    const response = await fetch("http://localhost:8585/partidos");
    const resultados = await response.json();
    actualizarDiv(resultados);
  } catch (error) {
    console.error(error);
  }
}

obtenerResultados();
refrescarBtn.addEventListener("click", obtenerResultados);
