#!/bin/bash

set -eu -o pipefail

for dir in 5.7 8.0; do
  pushd ${dir} >/dev/null
  ./push.sh
  popd
done
