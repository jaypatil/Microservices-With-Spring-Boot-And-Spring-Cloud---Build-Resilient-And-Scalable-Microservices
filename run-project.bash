#!/usr/bin/env bash
set -o xtrace

scripts/1_clean-docker-images.bash
scripts/2_build-em-all.bash
scripts/3_test-em-all.bash
scripts/4_test-database-entries.bash
