#!/usr/bin/env bash
set -euo pipefail

VERSION="0.3.0"
OUTPUT="command-switch-${VERSION}.plasmoid"

cd package
zip -r "../${OUTPUT}" .
cd ..

echo "Created $OUTPUT"
