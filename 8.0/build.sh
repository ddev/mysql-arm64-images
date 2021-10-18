#!/bin/bash
set -eu -o pipefail

BASE=${BASE:-drud/mysql:$(cat base_version.txt)}
MAJOR=${BASE%.*}

cp -r ../xtrabackup-8.0/install files

set -x
# Build only current architecture and load into docker
docker buildx build --target=mysql -t ${BASE} -t ${MAJOR} --load .