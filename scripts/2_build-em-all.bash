#!/usr/bin/env bash
set -o xtrace

# we can build all the microservices with one command:
./gradlew build && docker-compose build && docker-compose up
