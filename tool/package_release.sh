#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARCHIVE_NAME="aurora-loader"

echo "==> Cleaning Flutter artifacts"
(cd "$PROJECT_ROOT" && flutter clean >/dev/null)

echo "==> Removing temporary folders"
rm -rf "$PROJECT_ROOT/build" "$PROJECT_ROOT/.dart_tool" \
       "$PROJECT_ROOT/ios/Pods" "$PROJECT_ROOT/android/.gradle"

echo "==> Creating release archive"
(
  cd "$(dirname "$PROJECT_ROOT")"
  zip -r "${ARCHIVE_NAME}.zip" "$(basename "$PROJECT_ROOT")" \
    -x "*.DS_Store" "*.git*" "*/build/*" "*/.dart_tool/*" >/dev/null
)

echo "Archive created: $(dirname "$PROJECT_ROOT")/${ARCHIVE_NAME}.zip"
