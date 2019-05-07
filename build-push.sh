#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

docker build . -t quay.io/cmosetick/k8s-stern:latest
docker tag quay.io/cmosetick/k8s-stern:latest quay.io/cmosetick/k8s-stern:v1.10.0

docker push quay.io/cmosetick/k8s-stern:latest
docker push quay.io/cmosetick/k8s-stern:v1.10.0
