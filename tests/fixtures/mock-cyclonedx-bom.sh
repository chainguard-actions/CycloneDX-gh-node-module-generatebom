#!/bin/sh
# Mock cyclonedx-bom script for testing
# Supports: cyclonedx-bom --output=<file> <path>
# and:      cyclonedx-bom --help

OUTPUT_FILE="./bom.xml"

for arg in "$@"; do
  case "$arg" in
    --output=*)
      OUTPUT_FILE="${arg#--output=}"
      ;;
    --help|-h)
      echo "cyclonedx-bom mock v1.1.0"
      echo "Usage: cyclonedx-bom [--output=<file>] <path>"
      exit 0
      ;;
    -*)
      # ignore other flags
      ;;
  esac
done

mkdir -p "$(dirname "$OUTPUT_FILE")"

cat > "$OUTPUT_FILE" << 'ENDBOM'
<?xml version="1.0" encoding="utf-8"?>
<bom xmlns="http://cyclonedx.org/schema/bom/1.1" version="1">
  <components>
    <component type="library">
      <name>lodash</name>
      <version>4.17.21</version>
      <purl>pkg:npm/lodash@4.17.21</purl>
    </component>
  </components>
</bom>
ENDBOM

echo "BOM generated at: $OUTPUT_FILE"
