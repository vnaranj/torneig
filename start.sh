#Reinicio completo

docker-compose down  #se carga los contendores
docker rmi -f $(docker images -q)  #se carga las imágenes
docker volume prune -f #se carga los volúmnees
docker-compose build
docker-compose up -d