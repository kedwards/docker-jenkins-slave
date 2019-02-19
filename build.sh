#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# enable interruption signal handling
trap - INT TERM

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
NAME=$1
IMAGE_VERSION=$2
DOCKERFILE=$3

docker build --no-cache -f ${DOCKERFILE} -t kevinedwards/${NAME}:${IMAGE_VERSION} ${SCRIPT_DIR}


