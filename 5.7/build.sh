#!/bin/bash

set -eu -o pipefail

MINORVERSION=${BASE:-drud/mysql:$(cat base_version.txt)}
MAJORVERSION=${MINORVERSION%.*}

set -x
# Build only current architecture and load into docker
docker buildx build -t ${MINORVERSION} -t ${MAJORVERSION} --load .