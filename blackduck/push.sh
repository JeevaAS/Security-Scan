#!/bin/bash

set -euo pipefail

# run from script dir so CI doesn't need to `cd blackduck`
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-blackduck}"

if [ -z "${IMAGE_TAG:-}" ]; then
	echo "Error: IMAGE_TAG is not set. Set IMAGE_TAG to the image tag to push."
	exit 1
fi

IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING BLACK DUCK IMAGE"
echo "=============================================="

echo "Image: ${IMAGE}"

docker push "${IMAGE}"

echo ""
echo "Black Duck image successfully pushed."