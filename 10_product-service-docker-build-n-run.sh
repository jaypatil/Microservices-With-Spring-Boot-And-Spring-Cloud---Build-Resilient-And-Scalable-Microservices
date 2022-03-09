#!/usr/bin/env bash
set -o xtrace

# Building a Docker image

# To build the Docker image, we first need to build our deployment artifact,
# that is, the fat-jar-file, for product-service:
./gradlew :microservices:product-service:build

# We can find the fat-jar file in the Gradle build library, build/libs.
ls -l microservices/product-service/build/libs

cd microservices/product-service

#Next, we will build the Docker image and name it product-service, as follows:
docker build -t product-service .

#Verify that we got a Docker image, as expected, by using the following command:
docker images | grep product-service

#Let's start up the product microservice as a container by using the following command:
# To keep running on terminal
# docker run --rm -p8080:8080 -e "SPRING_PROFILES_ACTIVE=docker" product-service

#start the container detached – running the container without locking the Terminal!
docker run -d -p8080:8080 -e "SPRING_PROFILES_ACTIVE=docker" --name my-prd-srv product-service

#log output from our container, Meet the docker logs command:
#docker logs my-prd-srv

# Follow the log output from our container, Meet the docker logs command:
#docker logs my-prd-srv -f