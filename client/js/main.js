// div to dynamically insert HTML
const resultadosDiv = document.getElementById("resultados");

// Button to refresh results
const refrescarBtn = document.getElementById("refrescar");

function actualizarDiv(resultados) {
  let divHTML = "";
  resultados.forEach((resultado) => {
    const hora = new Date(resultado.fecha).toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });
    const golesLocal = parseInt(resultado.golesLocal);
    const golesVisitante = parseInt(resultado.golesVisitante);

    divHTML += `
      <div class="col-mg-6 col-sm-12 lg-4">
        <div class="card mb-3">
          <div class="card-body">
            <div class="d-flex justify-content-around align-items-center">
              <div class="equipo">
               
                
                <img width="100px" src="${resultado.equipoLocal === 'DAW 1' ? 'img/Logos/DAW1.png' : resultado.equipoLocal === 'ASIX 2' ? 'img/Logos/asix2.png'  :
                 resultado.equipoLocal === 'DAW 2' ? 'img/Logos/logo-placeholder.png' : resultado.equipoLocal === 'Profes' ? 'img/Logos/profes.png' :
                  resultado.equipoLocal === 'Comodín' ? 'img/Logos/logo-placeholder.png' :  resultado.equipoLocal === 'ASIX 1' ? 'img/Logos/asix1.png' : ''}" alt="${resultado.equipoLocal} logo">
               
                  <p class="card-title text-center ${resultado.equipoLocal === 'ASIX 1' ? 'ASIX' : resultado.equipoLocal === 'ASIX 2' ? 'ASIXT' :
                  resultado.equipoLocal === 'Profes' ? 'Profes' : resultado.equipoLocal === 'Comodín' ? 'Comodin' :
                  resultado.equipoLocal === 'DAW 1' ? 'DAW' : resultado.equipoLocal === 'DAW 2' ? 'DAWT' : ''}">${resultado.equipoLocal}</p>


                </div>
              <div class="resultado d-flex flex-column align-items-center ${golesLocal > golesVisitante ? 'ganador' : golesLocal < golesVisitante ? 'perdedor' : 'empate'}">
                ${golesLocal}
              </div>
              <div class="resultado d-flex flex-column align-items-center ${golesLocal < golesVisitante ? 'ganador' : golesLocal > golesVisitante ? 'perdedor' : 'empate'}">
                ${golesVisitante}
              </div>
              <div class="equipo">
              <img width="100px" src="${resultado.equipoVisitante === 'DAW 1' ? 'img/Logos/DAW1.png' : resultado.equipoVisitante === 'ASIX 2' ? 'img/Logos/asix2.png'  :
              resultado.equipoVisitante === 'DAW 2' ? 'img/Logos/logo-placeholder.png' : resultado.equipoVisitante === 'Profes' ? 'img/Logos/profes.png' :
               resultado.equipoVisitante === 'Comodín' ? 'img/Logos/logo-placeholder.png' : resultado.equipoVisitante === 'ASIX 1' ? 'img/Logos/asix1.png' : ''}" alt="${resultado.equipoVisitante} logo">
               

          
                <p class="card-title text-center ${resultado.equipoVisitante === 'ASIX 1' ? 'ASIX' : resultado.equipoVisitante === 'ASIX 2' ? 'ASIXT' :
                  resultado.equipoVisitante === 'Profes' ? 'Profes' : resultado.equipoVisitante === 'Comodín' ? 'Comodin' :
                  resultado.equipoVisitante === 'DAW 1' ? 'DAW' : resultado.equipoVisitante === 'DAW 2' ? 'DAWT' : ''}">${resultado.equipoVisitante}</p>
                  
              </div>
            </div>
            <p class="card-text text-center">${hora}</p>
          </div>
        </div>
      </div>`;
  });

  resultadosDiv.innerHTML = divHTML;
}

async function obtenerResultados() {
  try {
    const response = await fetch(backend + "/partidos");
    const resultados = await response.json();
    actualizarDiv(resultados);
  } catch (error) {
    console.error(error);
  }
}

obtenerResultados();
refrescarBtn.addEventListener("click", obtenerResultados);
