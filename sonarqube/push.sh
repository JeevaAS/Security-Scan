#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-sonarqube}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING SONARQUBE IMAGE"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

docker push "${IMAGE}"

echo ""
echo "Image successfully pushed."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'