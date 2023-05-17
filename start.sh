#!/bin/bash

#ANTES DE INICIAR TENER EN CUENTA PASAR EL PARAMETRO CONCRETO:
    #En local pasar el parametro local (.\start.sh local)
    #Si se recibe el parámetro 'full', se hace un reinicio completo
    #Si no, sólo se hace down y up
backend_msg="*******"

# Configurar la url dependiendo del entorno
if [ "$1" = "local" ] || [ "$2" = "local" ]; then
    backend_url=http://localhost:8585
    backend_msg="$backend_msg\nDesplegado en local.  Para otras opciones mira el archivo start.sh"
    backend_msg="$backend_msg\nServidor de backend:  $backend_url"
elif [ "$1" = "prod" ] || [ "$2" = "prod" ]; then
    backend_url=http://13.36.95.109:8585
    backend_msg="$backend_msg\nDesplegado en producción"
    backend_msg="$backend_msg\nServidor de backend:  $backend_url"
else
    backend_url=https://vnaranj-laughing-cod-wwvvqq4xpg7294w4-8585.preview.app.github.dev
    backend_msg="$backend_msg\nUtilizando codespaces. Para otras opciones mira el archivo start.sh"
    backend_msg="$backend_msg\nServidor de backend:  $backend_url"
    backend_msg="$backend_msg\nSi este no es tu servidor de backend, cámbialo en el archivo start.sh"
    backend_msg="$backend_msg\nY Recuerda abrir los puertos!!!!!"
fi

# Reemplazar el valor en el archivo JavaScript
sed -i "s|const backend='.*'|const backend='${backend_url}'|" ./client/js/common.js


docker-compose down  #se carga los contendores

if [ "$1" = "full" ]; then
    docker rmi -f $(docker images -q)  #se carga las imágenes
    docker volume prune -f #se carga los volúmenes
    docker-compose build  #vuelve a generar todas las imágenes
fi

docker-compose up -d #levanta todos los contenedores (los crea si es en modo full)

if [ -n "$backend_msg" ]; then
    echo -e "$backend_msg"
fi
