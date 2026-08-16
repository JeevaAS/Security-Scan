#!/bin/bash

set -euo pipefail

IMAGE="${JFROG_REGISTRY}/${JFROG_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " COVERITY IMAGE BUILD"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

docker build \
    --pull \
    --tag "${IMAGE}" \
    .

echo ""
echo "Coverity image successfully built."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'