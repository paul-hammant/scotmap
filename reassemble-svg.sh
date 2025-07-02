#!/bin/bash

# Reassemble individual authority SVGs into a single generated file
# Usage: ./reassemble-svg.sh

set -e

INPUT_DIR="authorities"
OUTPUT_SVG="scottish-local-authorities.svg"

echo "Reassembling SVGs from $INPUT_DIR/ into $OUTPUT_SVG..."

echo '<ns0:svg xmlns:ns0="http://www.w3.org/2000/svg" width="676" height="900" viewBox="0 0 676 900" version="1.1">
          <ns0:path d="M0,0 H678 V899 H0 Z" fill="#9ec7f1" />
' > $OUTPUT_SVG

cat r-of-uk.svg >> $OUTPUT_SVG
cat roi.svg >> $OUTPUT_SVG

    # Add each authority as an embedded SVG group
for svg_file in "$INPUT_DIR"/*.svg; do
    if [ -f "$svg_file" ]; then
        authority=$(basename "$svg_file" .svg)
        echo "<!-- Authority: $authority -->" >> $OUTPUT_SVG
        cat $svg_file >> $OUTPUT_SVG
    fi
done

cat coastline.svg >> $OUTPUT_SVG

echo "</ns0:svg>" >> $OUTPUT_SVG

echo "Generated $OUTPUT_SVG with embedded authority SVGs"
echo "File size: $(du -h "$OUTPUT_SVG" | cut -f1)"