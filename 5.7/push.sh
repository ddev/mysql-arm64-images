#!/bin/bash
set -eu -o pipefail

MINORVERSION=${BASE:-ddev/mysql:$(cat base_version.txt)}
MAJORVERSION=${MINORVERSION%.*}

echo "Pushing mysql:$MINORVERSION"
set -x
docker buildx use multi-arch-builder || docker buildx create --name multi-arch-builder --use
docker buildx build --target=mysql -t ${MINORVERSION} -t ${MAJORVERSION}  --push --platform=linux/arm64,linux/amd64 .
