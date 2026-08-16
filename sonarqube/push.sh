#!/bin/bash

set -euo pipefail

IMAGE="${JFROG_REGISTRY}/${JFROG_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING SONARQUBE IMAGE TO JFROG"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

docker push "${IMAGE}"

echo ""
echo "Image successfully pushed to JFrog."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'