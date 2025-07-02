#!/bin/bash

# Process include markers in template to generate final SVG
# This is like a simple preprocessor for SVG files

set -e

TEMPLATE_SVG="scotland-template.svg"
OUTPUT_SVG="scotland-generated.svg"

echo "Processing includes from $TEMPLATE_SVG..."

# Process the template line by line
while IFS= read -r line; do
    if [[ "$line" =~ ^[[:space:]]*\<!--[[:space:]]*#include[[:space:]]+([^[:space:]]+)[[:space:]]*--\> ]]; then
        # Extract the file path from the include comment
        include_file="${BASH_REMATCH[1]}"
        
        if [ -f "$include_file" ]; then
            echo "Including: $include_file"
            # Extract just the group content (skip SVG wrapper)
            sed -n '/<g id=/,/<\/g>$/p' "$include_file" | sed 's/^/        /'
        else
            echo "Warning: Include file not found: $include_file"
            echo "$line"  # Keep the original include comment
        fi
    else
        echo "$line"
    fi
done < "$TEMPLATE_SVG" > "$OUTPUT_SVG"

echo "Generated $OUTPUT_SVG"
echo "File size: $(du -h "$OUTPUT_SVG" | cut -f1)"