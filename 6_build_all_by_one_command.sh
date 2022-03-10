#!/usr/bin/env bash
set -o xtrace

# 4. Now, we can build all the microservices with one command:

./gradlew build
# If test are failing
#./gradlew build -x test

#> Run with --stacktrace option to get the stack trace.
#> Run with --info or --debug option to get more log output.
#> Run with --scan to get full insights.

