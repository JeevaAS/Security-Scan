#!/bin/bash

set -euo pipefail

IMAGE="${JFROG_REGISTRY}/${JFROG_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " PUSHING COVERITY IMAGE TO JFROG"
echo "=============================================="

docker push "${IMAGE}"

echo ""
echo "Coverity image successfully pushed."