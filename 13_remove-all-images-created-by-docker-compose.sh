#!/usr/bin/env bash
set -o xtrace

# Stop all Docker containers
docker kill $(docker ps -q)

# stop containers and remove
docker rm $(docker ps -a -q)

# Docker remove all images based on pattern
docker images -a | grep "script" | awk '{print $3}' | xargs docker rmi -f

# Docker remove all images irrespective of creation
docker rmi -f $(docker images -a -q)

# List all the images available (Check)
docker images -a
