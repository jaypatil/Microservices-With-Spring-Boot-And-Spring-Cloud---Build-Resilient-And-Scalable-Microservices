#!/usr/bin/env bash
set -o xtrace

# Let's build the project first
./gradlew build -x test

# Let's build the docker-compose.yml file
docker-compose build

# Let's check the images created by docker-compose.yml file
docker images -a |  grep "script"

# Lets run all the containers build by docker-compose.yml file
docker-compose up -d

# Print all the images are running
docker ps

# Print all the images are running by docker-compose.yml file
docker ps | grep "script"

# Check logs of all build by docker-compose.yml file
docker-compose logs -f