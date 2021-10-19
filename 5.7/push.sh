#!/bin/bash
set -eu -o pipefail

MINORVERSION=${BASE:-drud/mysql:$(cat base_version.txt)}
MAJORVERSION=${MINORVERSION%.*}

echo "Pushing mysql:$MINORVERSION"
set -x
# Build only current architecture and load into docker
docker buildx build --target=mysql -t ${MINORVERSION} -t ${MAJORVERSION}  --push --platform=linux/arm64,linux/amd64 .