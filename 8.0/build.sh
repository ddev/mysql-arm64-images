#!/bin/bash
set -eu -o pipefail

PACKAGE_VERSION=$(cat mysql_version.txt)
MYSQL_MINOR=${PACKAGE_VERSION%%-*}
MYSQL_MAJOR=${MYSQL_MINOR%.*}
XTRABACKUP_VERSION=$(cat xtrabackup_version.txt)

set -x
# Build only current architecture and load into docker
docker buildx build --build-arg=XTRABACKUP_VERSION="${XTRABACKUP_VERSION}" --build-arg="PACKAGE_VERSION=${PACKAGE_VERSION}" --target=mysql -t ${MYSQL_MAJOR} -t ${MYSQL_MINOR} --load .