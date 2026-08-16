#!/bin/bash

set -euo pipefail

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-sonarqube}"
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

echo ""
echo "Image ID:"
docker image inspect "${IMAGE}" \
    --format '{{.Id}}'