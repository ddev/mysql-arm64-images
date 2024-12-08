#!/bin/bash
set -eu -o pipefail

REPO_NAME=ddev/mysql
MYSQL_PACKAGE_VERSION=$(cat mysql_version.txt)
MYSQL_MINOR=${MYSQL_PACKAGE_VERSION%%-*}
MYSQL_MAJOR=${MYSQL_MINOR%.*}
XTRABACKUP_PACKAGE_VERSION=$(cat xtrabackup_version.txt)

set -x
# Build only current architecture and load into docker
docker buildx build --progress plain --no-cache --build-arg=XTRABACKUP_PACKAGE_VERSION="${XTRABACKUP_PACKAGE_VERSION}" --build-arg="MYSQL_PACKAGE_VERSION=${MYSQL_PACKAGE_VERSION}" --target=mysql -t ${REPO_NAME}:${MYSQL_MAJOR} -t ${REPO_NAME}:${MYSQL_MINOR} .
