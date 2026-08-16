#!/bin/bash
set -euo pipefail

# Usage: ./trivy-scan.sh <image>
IMAGE="$1"

JSON_REPORT="trivy-results.json"
TABLE_REPORT="trivy-results.txt"
SUMMARY_REPORT="trivy-summary.md"

echo ""
echo "=========================================="
echo " TRIVY CONTAINER IMAGE SCAN"
echo "=========================================="
echo ""
echo "Image: $IMAGE"
echo ""
echo "Starting Trivy scan..."

# JSON report
trivy image \
  --format json \
  --output "$JSON_REPORT" \
  "$IMAGE"

# Human-readable report
trivy image \
  --severity UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL \
  --format table \
  "$IMAGE" | tee "$TABLE_REPORT"

echo ""
echo "=========================================="
echo " VULNERABILITY SUMMARY"
echo "=========================================="

# Parse counts using jq
Critical=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length' "$JSON_REPORT")
High=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="HIGH")] | length' "$JSON_REPORT")
Medium=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="MEDIUM")] | length' "$JSON_REPORT")
Low=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="LOW")] | length' "$JSON_REPORT")
Unknown=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="UNKNOWN")] | length' "$JSON_REPORT")

Total=$((Critical + High + Medium + Low + Unknown))

echo "CRITICAL : $Critical"
echo "HIGH     : $High"
echo "MEDIUM   : $Medium"
echo "LOW      : $Low"
echo "UNKNOWN  : $Unknown"
echo "TOTAL    : $Total"

cat > "$SUMMARY_REPORT" <<EOF
# Trivy Container Vulnerability Report

## Image

$IMAGE

## Vulnerability Summary

| Severity | Count |
|---|---:|
| 🔴 Critical | $Critical |
| 🟠 High | $High |
| 🟡 Medium | $Medium |
| 🔵 Low | $Low |
| ⚪ Unknown | $Unknown |
| **Total** | **$Total** |

## Scan Result

The image was scanned before promotion.

Manual approval is required before pushing the image to the local registry.
EOF

echo ""
echo "=========================================="
echo " COMPLETE TRIVY REPORT"
echo "=========================================="
cat "$TABLE_REPORT"
echo ""
echo "Trivy scan completed."
