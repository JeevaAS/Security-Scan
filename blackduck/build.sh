#!/bin/bash

set -euo pipefail

# Ensure script runs relative to its directory so it works from anywhere
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-blackduck}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " BLACK DUCK IMAGE BUILD"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

# Ensure detect.jar is present in the build context. If not, download using DETECT_URL.
if [ ! -f "${script_dir}/detect.jar" ]; then
    if [ -n "${DETECT_URL:-}" ]; then
        echo "detect.jar not found, downloading from ${DETECT_URL}..."
        curl -fsSL -o detect.jar "${DETECT_URL}"
        echo "Downloaded detect.jar"
    else
        echo "Error: detect.jar not found in ${script_dir}."
        echo "Provide a detect.jar file in the blackduck directory or set the DETECT_URL environment variable to download it automatically."
        exit 1
    fi
fi

docker build \
    --pull \
    --tag "${IMAGE}" \
    .

echo ""
echo "Black Duck image successfully built."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'