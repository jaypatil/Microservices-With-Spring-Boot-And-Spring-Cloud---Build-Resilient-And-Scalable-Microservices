#!/usr/bin/env bash
set -o xtrace

# We can build each microservice separately with the following command:

cd microservices/product-composite-service; ./gradlew build; cd -; \
cd microservices/product-service; ./gradlew build; cd -; \
cd microservices/recommendation-service; ./gradlew build; cd -; \
cd microservices/review-service; ./gradlew build; cd -; 
cd api ./gradlew build; cd -;
cd util ./gradlew build; cd -; 