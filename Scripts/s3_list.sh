#!/usr/bin/env bash
set -euo pipefail

# Output file (goes one folder up = repo root)
OUT_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/s3_report.txt"

{
  echo "==== S3 BUCKET LIST @ $(date -u +'%Y-%m-%d %H:%M:%S UTC') ===="
  aws s3 ls
} > "$OUT_FILE"
