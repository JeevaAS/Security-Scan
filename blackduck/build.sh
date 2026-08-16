#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-blackduck}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " BLACK DUCK IMAGE BUILD"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

docker build \
    --pull \
    --tag "${IMAGE}" \
    .

echo ""
echo "Black Duck image successfully built."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'