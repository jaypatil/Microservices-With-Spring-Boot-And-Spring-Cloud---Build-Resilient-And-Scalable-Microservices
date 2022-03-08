#!/usr/bin/env bash
set -o xtrace

# 2. Next, we copy the Gradle executable files that were generated from one of the projects so that we can reuse them for the multi-project builds:

cp -r microservices/product-service/gradle .
cp microservices/product-service/gradlew .
cp microservices/product-service/gradlew.bat .
cp microservices/product-service/.gitignore .