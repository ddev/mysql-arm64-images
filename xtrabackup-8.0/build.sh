#!/bin/bash
# This script builds percona-xtrabackup-8.0 for arm64
# It's intended to run on an Ubuntu 20.04 arm64 machine, like CircleCI arm64

set -eu -o pipefail
VERSION=$(cat base_version.txt)

apt-get -y install dirmngr cmake lsb-release wget  build-essential flex bison automake autoconf libtool cmake libaio-dev mysql-client libncurses-dev zlib1g-dev libev-dev libcurl4-gnutls-dev vim-common devscripts  libnuma-dev openssl libssl-dev libgcrypt20-dev

if [ ! -d percona-xtrabackup/.git ]; then
  rm -rf percona-xtrabackup && git clone https://github.com/percona/percona-xtrabackup.git
fi
cd percona-xtrabackup && git fetch origin && git checkout percona-xtrabackup-${VERSION}