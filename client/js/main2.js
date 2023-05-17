// div para poder meter el html dinámico
const resultadosDiv = document.getElementById('resultados');

// Botón para refrescar resultados
const refrescarBtn = document.getElementById('refrescar');

function actualizarDiv(resultados) {
  let divHTML = '';
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
            <p class="card-title text-center">${resultado.equipoLocal}</p>
          </div>
          <div class="resultado d-flex flex-column align-items-center ${golesLocal > golesVisitante ? 'ganador' : golesLocal < golesVisitante ? 'perdedor' : 'empate'}">
            <input type="text" class="form-control goles" value="${golesLocal}">
          </div>
          <div class="resultado d-flex flex-column align-items-center ${golesLocal < golesVisitante ? 'ganador' : golesLocal > golesVisitante ? 'perdedor' : 'empate'}">
            <input type="text" class="form-control goles" value="${golesVisitante}">
          </div>
          <div class="equipo">
            <p class="card-title text-center">${resultado.equipoVisitante}</p>
          </div>
        </div><input type="hidden" name="idPartido" value="${resultado.id}">
        <button class="btn btn-primary" onclick="actualizarResultado(this)">
        Actualizar 
          <span class="fecha" style="display: block; font-size: 40%;">(${hora})</span>
        </button>
      </div>
    </div>
  </div>
    `;
  });
  resultadosDiv.innerHTML = divHTML;
}

async function obtenerResultados() {
  try {
    const response = await fetch(backend + '/partidos');
    const resultados = await response.json();
    actualizarDiv(resultados);
  } catch (error) {
    console.error(error);
  }
}

async function actualizarResultado(btn) {
  try {
    const cardBody = btn.closest('.card-body');
    const idPartido = cardBody.querySelector('input[name="idPartido"]').value;
    const golesLocal = cardBody.querySelectorAll('input')[0].value;
    const golesVisitante = cardBody.querySelectorAll('input')[1].value;

    const response = await fetch(backend + '/resultado', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        id: idPartido,
        golesLocal: golesLocal,
        golesVisitante: golesVisitante
      })
    });
    //const data = await response.json();
    //console.log(data);
    if (response.status === 200) {
      alert('Resultado actualizado correctamente');
    }else{
      alert('Fallo actualizando');
    }

  } catch (error) {
    console.error(error);
  }
}

obtenerResultados();
refrescarBtn.addEventListener('click', obtenerResultados);
