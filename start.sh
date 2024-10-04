#!/bin/bash
docker stop containerized-ide
docker start containerized-ide
docker exec -it containerized-ide sh -c "cd /app/frontend/ && npm run both"
