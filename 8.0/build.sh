#!/bin/bash
set -eu -o pipefail

REPO_NAME=drud/mysql
MYSQL_PACKAGE_VERSION=$(cat mysql_version.txt)
MYSQL_MINOR=${MYSQL_PACKAGE_VERSION%%-*}
MYSQL_MAJOR=${MYSQL_MINOR%.*}
XTRABACKUP_VERSION=$(cat xtrabackup_version.txt)

set -x
# Build only current architecture and load into docker
docker buildx build --build-arg=XTRABACKUP_VERSION="${XTRABACKUP_VERSION}" --build-arg="MYSQL_PACKAGE_VERSION=${MYSQL_PACKAGE_VERSION}" --target=mysql -t ${REPO_NAME}:${MYSQL_MAJOR} -t ${REPO_NAME}:${MYSQL_MINOR} .