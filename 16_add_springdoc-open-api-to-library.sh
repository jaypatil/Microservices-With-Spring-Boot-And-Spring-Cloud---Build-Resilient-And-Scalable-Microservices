#!/usr/bin/env bash
set -o xtrace

PIVIOT_FOR_ADD_EXT="(dependencies[[:space:]]\{)"
REPLACE_EXT_VERSION="ext \{\n\tspringBootVersion = \'${SPRING_BOOT_VERSION}\'\n\}\n\n"
REPLACE_EXT_DEPENDENCIES="\n\timplementation platform(\"org.springframework.boot:spring-boot-dependencies:\$\{springBootVersion\}\")"

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