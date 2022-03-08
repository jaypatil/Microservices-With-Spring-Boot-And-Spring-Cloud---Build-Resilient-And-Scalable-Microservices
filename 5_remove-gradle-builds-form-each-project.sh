#!/usr/bin/env bash
set -o xtrace

# 3. We no longer need the generated Gradle executable files in each project, so we can remove them with the following commands:

find microservices -depth -name "gradle" -exec rm -rfv "{}" \;
find microservices -depth -name "gradlew*" -exec rm -fv "{}" \;

find api -depth -name "gradle" -exec rm -rfv "{}" \;
find api -depth -name "gradlew*" -exec rm -fv "{}" \;

find util -depth -name "gradle" -exec rm -rfv "{}" \;
find util -depth -name "gradlew*" -exec rm -fv "{}" \;