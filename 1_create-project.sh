#!/usr/bin/env bash
set -o xtrace

# create the four projects

# microservices/
# ├── product-composite-service
# ├── product-service
# ├── recommendation-service
# └── review-service

# api/core
# ├── product
# │   ├── Product.java
# │   └── ProductService.java
# ├── recommendation
# │   ├── Recommendation.java
# │   └── RecommendationService.java
# └── review
#     ├── Review.java
#     └── ReviewService.java

mkdir microservices
cd microservices

SPRING_BOOT_VERSION=2.6.4
JAVA_VERSION=17
PROJECT_VERSION=0.0.1-SNAPSHOT

spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=product-service \
--package-name=example.microservices.core.product \
--groupId=example.microservices.core.product \
--dependencies=actuator,webflux \
--version=$PROJECT_VERSION \
product-service

spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=review-service \
--package-name=example.microservices.core.review \
--groupId=example.microservices.core.review \
--dependencies=actuator,webflux \
--version=$PROJECT_VERSION \
review-service

spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=recommendation-service \
--package-name=example.microservices.core.recommendation \
--groupId=example.microservices.core.recommendation \
--dependencies=actuator,webflux \
--version=$PROJECT_VERSION \
recommendation-service

spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=product-composite-service \
--package-name=example.microservices.composite.product \
--groupId=example.microservices.composite.product \
--dependencies=actuator,webflux \
--version=$PROJECT_VERSION \
product-composite-service

cd ..

#!/usr/bin/env bash
set -o xtrace

OS=`uname`

# Unfortunately, Spring Initializr doesn't support the creation of library projects. Instead, a library project has to be created manually from scratch.
# create the libray project


PIVIOT_FOR_ADD_EXT="(dependencies[[:space:]]\{)"
REPLACE_EXT_VERSION="ext \{\n\tspringBootVersion = \'${SPRING_BOOT_VERSION}\'\n\}\n\n"
REPLACE_EXT_DEPENDENCIES="\n\timplementation platform(\"org.springframework.boot:spring-boot-dependencies:\$\{springBootVersion\}\")"

spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=api \
--package-name=example.api \
--groupId=example.microservices.api \
--dependencies=webflux \
--version=$PROJECT_VERSION \
api


spring init \
--boot-version=$SPRING_BOOT_VERSION \
--build=gradle \
--java-version=$JAVA_VERSION \
--packaging=jar \
--name=util \
--package-name=example.util \
--groupId=example.microservices.util \
--dependencies=webflux \
--version=$PROJECT_VERSION \
util

 if [ "$OS" = 'Darwin' ]; then
    # for MacOS sed -i '' -e "$1" "$2"
    sed -i '' -E "s#${PIVIOT_FOR_ADD_EXT}#${REPLACE_EXT_VERSION}\1#" ./api/build.gradle
    sed -i '' -E "s#${PIVIOT_FOR_ADD_EXT}#\1${REPLACE_EXT_DEPENDENCIES}#" ./api/build.gradle
    sed -i '' -E "s#${PIVIOT_FOR_ADD_EXT}#${REPLACE_EXT_VERSION}\1#" ./util/build.gradle
    sed -i '' -E "s#${PIVIOT_FOR_ADD_EXT}#\1${REPLACE_EXT_DEPENDENCIES}#" ./util/build.gradle
else
    # TODO test and check for bug
    # for Linux and Windows sed -i'' -e "$1" "$2"
    sed -i'' -e "s/${PIVIOT_FOR_ADD_EXT}/${REPLACE_EXT_VERSION}\1/" ./api/build.gradle
    sed -i'' -e "s/${PIVIOT_FOR_ADD_EXT}/\1${REPLACE_EXT_DEPENDENCIES}/" ./api/build.gradle
    sed -i'' -e "s/${PIVIOT_FOR_ADD_EXT}/${REPLACE_EXT_VERSION}\1/" ./util/build.gradle
    sed -i'' -e "s/${PIVIOT_FOR_ADD_EXT}/\1${REPLACE_EXT_DEPENDENCIES}/" ./util/build.gradle
fi