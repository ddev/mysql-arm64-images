#!/bin/bash

set -eu -o pipefail
set -x

V=mysql-8.0.32

rm -rf ${V} && mkdir -p $V/archives-{amd64,arm64}/partial && chmod -R ugo+rw $V/archives-{amd64,arm64} && sudo chown -R root $V/archives-{amd64,arm64}

for PLATFORM in arm64 amd64; do
  docker run --rm --platform linux/$PLATFORM -v $PWD/$V/archives-$PLATFORM:/var/cache/apt/archives --name mysql-$PLATFORM --rm ubuntu:22.04 bash -c "apt-get update && apt-get upgrade -y && apt-get install -y --download-only mysql-server"
done

rm -rf ${V}/archives*/{lock,partial}
