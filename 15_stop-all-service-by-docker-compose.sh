#!/usr/bin/env bash
set -o xtrace

# Lets stop all the containers build by docker-compose.yml file
docker-compose down

# Stop all Docker containers
docker kill $(docker ps -q)

# stop containers and remove
docker rm $(docker ps -a -q)

# Docker remove all images based on pattern
docker images -a | grep "script" | awk '{print $3}' | xargs docker rmi -f

# List all the images available (Check)
docker images -a
