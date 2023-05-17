//div para poder meter el html dinámico
const resultadosDiv = document.getElementById("resultados");

//Botón para refrescar resultados
const refrescarBtn = document.getElementById("refrescar");


async function obtenerPuntuaciones() {
  try {
    const response = await fetch(backend + "/partidos");
    const partidos = await response.json();
    const equipos = {};
    partidos.forEach(partido => {

      const equipoLocal = partido.equipoLocal;
      const equipoVisitante = partido.equipoVisitante;
      const golesLocal = parseInt(partido.golesLocal);
      const golesVisitante = parseInt(partido.golesVisitante);
      if (!equipos[equipoLocal]) {
        equipos[equipoLocal] = { nombre: equipoLocal, puntuacion: 0 };
      }
      if (!equipos[equipoVisitante]) {
        equipos[equipoVisitante] = { nombre: equipoVisitante, puntuacion: 0 };
      }
      if(partido.jugado == true) {
        if (golesLocal > golesVisitante) {
          equipos[equipoLocal].puntuacion += 3;
        } else if (golesLocal < golesVisitante) {
          equipos[equipoVisitante].puntuacion += 3;
        } else {
          equipos[equipoLocal].puntuacion += 1;
          equipos[equipoVisitante].puntuacion += 1;
        }
      } 
    });

    const listaEquipos = Object.values(equipos).sort((a, b) => {
      if (b.puntuacion - a.puntuacion !== 0) {
        return b.puntuacion - a.puntuacion;
      } else if (a.nombre === "DAW 1") {
        return -1;
      } else if (b.nombre === "DAW 1") {
        return 1;
      } else {
        return 0;
    }
});

    console.log(listaEquipos);

    listaEquipos.forEach((equipo, index) => {
      equipo.posicion = index + 1;
    });


    return listaEquipos;
  } catch (error) {
    console.error(error);
  }
}

async function crearListaPuntuaciones() {
  try {
    const listaEquipos = await obtenerPuntuaciones();
    let divHTML = "";
    listaEquipos.forEach((equipo) => {
      divHTML += `
      <div class="col-mg-6 col-sm-12 lg-4">
        <div class="card mb-3">
          <div class="card-body">
            <div class="d-flex justify-content-around align-items-center">
              <div class="resultado d-flex flex-column align-items-center puntos">
                ${equipo.posicion}
              </div>
              <div class="equipo text-center">
                <p class="card-title" style="font-size: 24px">${equipo.nombre}</p>
              </div>
              <div class="resultado d-flex flex-column align-items-center puntos">
                ${equipo.puntuacion}
              </div>
            </div>
          </div>
        </div>
      </div>
      `;
    });
    resultadosDiv.innerHTML = divHTML;
  } catch (error) {
    console.error(error);
  }
}

crearListaPuntuaciones();
refrescarBtn.addEventListener("click", crearListaPuntuaciones);
