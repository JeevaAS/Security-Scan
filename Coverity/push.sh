#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-coverity}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING COVERITY IMAGE"
echo "=============================================="

docker push "${IMAGE}"

echo ""
echo "Coverity image successfully pushed."