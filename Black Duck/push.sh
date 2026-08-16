#!/bin/bash

set -euo pipefail

IMAGE="${JFROG_REGISTRY}/${JFROG_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING BLACK DUCK IMAGE TO JFROG"
echo "=============================================="

docker push "${IMAGE}"

echo ""
echo "Black Duck image successfully pushed."