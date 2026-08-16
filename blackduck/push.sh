#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-blackduck}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING BLACK DUCK IMAGE"
echo "=============================================="

docker push "${IMAGE}"

echo ""
echo "Black Duck image successfully pushed."