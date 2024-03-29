#!/bin/bash

set -eu -o pipefail

MINORVERSION=${BASE:-ddev/mysql:$(cat base_version.txt)}
MAJORVERSION=${MINORVERSION%.*}

set -x
# Build only current architecture and load into docker
docker buildx build --target=mysql -t ${MINORVERSION} -t ${MAJORVERSION} --load .
