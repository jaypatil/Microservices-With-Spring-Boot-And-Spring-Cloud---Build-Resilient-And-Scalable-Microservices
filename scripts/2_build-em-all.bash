#!/usr/bin/env bash
set -o xtrace

# 4. Now, we can build all the microservices with one command:
./gradlew build --info
#./gradlew build

# turn up dataabase first so end to end test case should pass``
docker-compose up -d