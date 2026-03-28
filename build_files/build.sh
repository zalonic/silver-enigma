#!/usr/bin/env bash

set -eo pipefail

SCRIPTS_PATH="$(realpath "$(dirname "$0")")"
MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo ${VERSION_ID%.*}')"
SCRIPTS_PATH="$(realpath "$(dirname "$0")/scripts")"
export SCRIPTS_PATH
export MAJOR_VERSION_NUMBER

printf "::group:: ===Image Base===\n"
"${SCRIPTS_PATH}/01-base.sh"
printf "::endgroup::\n"

printf "::group:: ===Install CachyKernel===\n"
# "${SCRIPTS_PATH}/02-cachy-kernel.sh"
printf "::endgroup::\n"

printf "::group:: ===OS Release===\n"
"${SCRIPTS_PATH}/update-os-release.sh"
printf "::endgroup::\n"

printf "::group:: ===Image Cleanup===\n"
"${SCRIPTS_PATH}/cleanup.sh"
printf "::endgroup::\n"
