#!/bin/bash

BASE=${BASE:-drud/mysql:8.0.26}
MAJOR=${BASE%.*}

# Build only current architecture and load into docker
docker buildx build -t ${BASE} -t ${MAJOR} --load .