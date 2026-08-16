#!/bin/bash

set -euo pipefail

# run from script dir so CI doesn't need to `cd sonarqube`
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-sonarqube}"

if [ -z "${IMAGE_TAG:-}" ]; then
  echo "Error: IMAGE_TAG is not set. Set IMAGE_TAG to the image tag to build."
  exit 1
fi

IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " SONARQUBE IMAGE BUILD"
echo "=============================================="

echo "Registry : ${REGISTRY}"
echo "Repository : ${REPOSITORY}"
echo "Image : ${IMAGE}"

docker build \
    --pull \
    --tag "${IMAGE}" \
    .

echo ""
echo "Docker image successfully built:"
echo "${IMAGE}"

docker image inspect "${IMAGE}" > image-inspect.json

docker image inspect "${IMAGE}" \
  --format '{{.Id}}' > built-image-id.txt
echo ""
echo "Image ID: $(cat built-image-id.txt)"