#!/bin/bash

set -euo pipefail

IMAGE="${JFROG_REGISTRY}/${JFROG_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " SONARQUBE IMAGE BUILD"
echo "=============================================="

echo "JFrog Registry : ${JFROG_REGISTRY}"
echo "Repository     : ${JFROG_REPOSITORY}"
echo "Image          : ${IMAGE}"

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