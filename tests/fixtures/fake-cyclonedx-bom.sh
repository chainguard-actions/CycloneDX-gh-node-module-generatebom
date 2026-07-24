#!/bin/sh
# Fake cyclonedx-bom script for testing
# Supports --help, --version, and --output=FILE PATH

OUTPUT_FILE=""
INPUT_PATH="."

for arg in "$@"; do
  case "$arg" in
    --help|-h)
      echo "cyclonedx-bom [options] [path]"
      echo "  -o, --output  Output file"
      exit 0
      ;;
    --version|-v)
      echo "3.10.6"
      exit 0
      ;;
    --output=*)
      OUTPUT_FILE="${arg#--output=}"
      ;;
    -o)
      # next arg is the output file - handled below
      ;;
    *)
      # treat as input path if not a flag
      case "$arg" in
        -*) ;;
        *) INPUT_PATH="$arg" ;;
      esac
      ;;
  esac
done

# Handle -o <file> style (two-arg form)
prev=""
for arg in "$@"; do
  if [ "$prev" = "-o" ]; then
    OUTPUT_FILE="$arg"
  fi
  prev="$arg"
done

# Generate a minimal CycloneDX BOM XML
BOM_CONTENT='<?xml version="1.0" encoding="utf-8"?>
<bom xmlns="http://cyclonedx.org/schema/bom/1.2" version="1">
  <metadata>
    <timestamp>2024-01-01T00:00:00Z</timestamp>
    <tools>
      <tool>
        <vendor>CycloneDX</vendor>
        <name>cyclonedx-bom</name>
        <version>3.10.6</version>
      </tool>
    </tools>
  </metadata>
  <components>
    <component type="library">
      <name>lodash</name>
      <version>4.17.21</version>
      <purl>pkg:npm/lodash@4.17.21</purl>
      <licenses>
        <license>
          <id>MIT</id>
        </license>
      </licenses>
    </component>
  </components>
</bom>'

if [ -n "$OUTPUT_FILE" ]; then
  echo "$BOM_CONTENT" > "$OUTPUT_FILE"
  echo "Generated BOM at: $OUTPUT_FILE"
else
  echo "$BOM_CONTENT"
fi

exit 0
