#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-coverity}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

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