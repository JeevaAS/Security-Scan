#!/bin/bash

set -euo pipefail

# run from script dir so CI doesn't need to `cd sonarqube`
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-sonarqube}"

if [ -z "${IMAGE_TAG:-}" ]; then
    echo "Error: IMAGE_TAG is not set. Set IMAGE_TAG to the image tag to push."
    exit 1
fi

IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING SONARQUBE IMAGE"
echo "=============================================="

echo "Image: ${IMAGE}"

docker push "${IMAGE}"

echo ""
echo "Image successfully pushed."

docker image inspect "${IMAGE}" \
        --format 'Image ID: {{.Id}}'