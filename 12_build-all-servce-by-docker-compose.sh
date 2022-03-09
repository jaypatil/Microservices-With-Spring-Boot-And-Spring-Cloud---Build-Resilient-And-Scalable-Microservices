#!/usr/bin/env bash
set -o xtrace

docker-compose build

# List all the images available
docker images -a

# List all the images available
docker images -a |  grep "script"