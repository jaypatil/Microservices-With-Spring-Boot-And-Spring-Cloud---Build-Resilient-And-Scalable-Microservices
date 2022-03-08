q#!/usr/bin/env bash
set -o xtrace

# 1. First, we create the settings.gradle file, which describes what projects Gradle should build:

cat <<EOF > settings.gradle
include ':api'
include ':util'
include ':microservices:product-service'
include ':microservices:review-service'
include ':microservices:recommendation-service'
include ':microservices:product-composite-service'
EOF