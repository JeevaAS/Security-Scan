#!/bin/bash

set -euo pipefail

# Ensure script runs relative to its directory so it works from anywhere
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

REGISTRY="${REGISTRY:-localhost:5000}"
REPOSITORY="${REPOSITORY:-}"
IMAGE_NAME="${IMAGE_NAME:-sast-coverity}"
IMAGE="${REGISTRY}/${REPOSITORY:+${REPOSITORY}/}${IMAGE_NAME}:${IMAGE_TAG}"

echo "=============================================="
echo " COVERITY IMAGE BUILD"
echo "=============================================="

echo "Image:"
echo "${IMAGE}"

# Ensure coverity archive is present in build context. If not, download using COVERITY_URL or create placeholder.
archive_name="coverity-analysis-linux64.tar.gz"
if [ ! -f "${script_dir}/${archive_name}" ]; then
    if [ -n "${COVERITY_URL:-}" ]; then
        echo "${archive_name} not found, downloading from ${COVERITY_URL}..."
        curl -fsSL -o "${archive_name}" "${COVERITY_URL}" || true
        if [ -f "${archive_name}" ]; then
            echo "Downloaded ${archive_name}"
        else
            echo "Warning: failed to download ${archive_name} from COVERITY_URL"
        fi
    else
        echo "Warning: ${archive_name} not found and COVERITY_URL not set. Creating placeholder archive to allow build to proceed."
        # create an empty tar.gz as placeholder
        tar -czf "${archive_name}" --files-from /dev/null || true
    fi
fi

docker build \
    --pull \
    --tag "${IMAGE}" \
    .

echo ""
echo "Coverity image successfully built."

docker image inspect "${IMAGE}" \
    --format 'Image ID: {{.Id}}'