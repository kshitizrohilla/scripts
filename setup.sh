#!/bin/bash
set -e
docker run --privileged -p 3000:3000 -p 5000:5000 -p 5001:5001 -p 5002:5002 --name containerized-ide -d docker:dind
sleep 10
docker exec containerized-ide apk update
docker exec containerized-ide apk add nodejs npm vim git
docker exec containerized-ide git clone -b main-dev https://github.com/kshitizrohilla/ide.git /app
docker exec containerized-ide git clone -b main https://github.com/kshitizrohilla/docker-image.git /app/docker-image
docker exec -w /app/docker-image containerized-ide docker build -t custom_express .
docker exec -w /app/backend containerized-ide npm -g i nodemon concurrently
docker exec -w /app/backend containerized-ide npm i
docker exec -w /app/frontend containerized-ide npm i
docker exec -w /app/frontend containerized-ide npm run both
