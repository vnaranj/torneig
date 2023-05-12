#!/bin/bash

#Si se recibe el parámetro 'full', se hace un reinicio completo
#Si no, sólo se hace down y up

docker-compose down  #se carga los contendores

if [ "$1" = "full" ]; then
    docker rmi -f $(docker images -q)  #se carga las imágenes
    docker volume prune -f #se carga los volúmenes
    docker-compose build. #vuelve a generar todas las imágenes
fi

docker-compose up -d #levanta todos los contenedores (los crea si es en modo full)
