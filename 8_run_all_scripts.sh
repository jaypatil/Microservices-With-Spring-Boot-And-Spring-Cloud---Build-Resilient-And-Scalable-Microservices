#!/usr/bin/env bash
set -o xtrace

sh clean.sh

echo "Exexuting.... 1_create-project.sh"
sh 1_create-project.sh
echo "Exit status 1_create-project.sh, ok."

echo "Exexuting.... 1_verify_the_files_created.sh"
sh 1_verify_the_files_created.sh
echo "Exit status 1_verify_the_files_created.sh, ok."

echo "Exexuting.... 2_build-each-microservice-seprately.sh"
sh 2_build-each-microservice-seprately.sh
echo "Exit status 2_build-each-microservice-seprately.sh, ok."

echo "Exexuting.... 3_create-gradle-settings.sh"
sh 3_create-gradle-settings.sh
echo "Exit status 3_create-gradle-settings.sh, ok."

echo "Exexuting.... 4_copy-gradle-builds-for-multi-project-builds.sh"
sh 4_copy-gradle-builds-for-multi-project-builds.sh
echo "Exit status 4_copy-gradle-builds-for-multi-project-builds.sh, ok."

echo "Exexuting.... 5_remove-gradle-builds-form-each-project.sh"
sh 5_remove-gradle-builds-form-each-project.sh
echo "Exit status 5_remove-gradle-builds-form-each-project.sh, ok."

echo "Exexuting.... 6_build_all_by_one_command.sh"
sh 6_build_all_by_one_command.sh
echo "Exit status 6_build_all_by_one_command.sh, ok."