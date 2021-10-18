#!/bin/bash
set -eu -o pipefail

BASE=${BASE:-drud/mysql:$(cat base_version.txt)}
MAJOR=${BASE%.*}

# Build only current architecture and load into docker
docker buildx build -t ${BASE} -t ${MAJOR} --load .