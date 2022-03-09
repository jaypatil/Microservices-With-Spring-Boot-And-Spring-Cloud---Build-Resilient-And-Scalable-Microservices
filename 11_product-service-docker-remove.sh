#!/usr/bin/env bash
set -o xtrace

# List all running container
docker ps

# stopping and removing the container:
docker rm -f my-prd-srv

# List all running container
docker ps

