#!/bin/bash

#Si se recibe el parámetro 'full', se hace un reinicio completo
#Si no, sólo se hace down y up

# Configurar la url dependiendo del entorno
if [ "$1" = "local" ] || [ "$2" = "local" ]; then
    backend_url=http://localhost:8585
elif [ "$1" = "prod" ] || [ "$2" = "prod" ]; then
    backend_url=http://13.36.95.109:8585
else
    backend_url=https://vnaranj1-psychic-parakeet-gwj5qj9g6jp396rg-8585.preview.app.github.dev/
fi

# Reemplazar el valor en el archivo JavaScript
sed -i "s|const backend='.*'|const backend='${backend_url}'|" ./client/js/common.js


docker-compose down  #se carga los contendores

if [ "$1" = "full" ]; then
    docker rmi -f $(docker images -q)  #se carga las imágenes
    docker volume prune -f #se carga los volúmenes
    docker-compose build. #vuelve a generar todas las imágenes
fi

docker-compose up -d #levanta todos los contenedores (los crea si es en modo full)
