#!/bin/bash

BASE=${BASE:-drud/mysql:5.7.35}
MAJOR=${BASE%.*}

# Build only current architecture and load into docker
docker buildx build -t ${BASE} -t ${MAJOR} --load .