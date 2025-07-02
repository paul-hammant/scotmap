#!/bin/bash

# Split Scotland SVG by authority and create reassembly script
# Usage: ./split-svg.sh

set -e

INPUT_SVG="scottish-local-authorities-with-labels-and-links.svg"
OUTPUT_DIR="authorities"
GENERATED_SVG="scotland-generated.svg"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Extract SVG header and footer
echo "Extracting SVG structure..."
head -4 "$INPUT_SVG" > svg_header.tmp
echo '</svg>' > svg_footer.tmp

# Get line numbers for each authority group
echo "Finding authority boundaries..."
grep -n '<g id=' "$INPUT_SVG" | grep -v 'scottish-local-authorities-text\|background' > authorities.tmp

# Extract each authority as separate SVG
echo "Splitting authorities..."
while IFS=':' read -r line_num line_content; do
    # Extract authority name from id
    authority=$(echo "$line_content" | sed 's/.*id="\([^"]*\)".*/\1/')
    
    if [ "$authority" != "scottish-local-authorities-text" ] && [ "$authority" != "background" ]; then
        echo "Processing: $authority"
        
        # Find the end of this group by looking for the next </g> at the same level
        start_line=$line_num
        
        # Count opening and closing g tags to find matching close
        temp_file=$(mktemp)
        tail -n +$start_line "$INPUT_SVG" > "$temp_file"
        
        # Find matching closing </g>
        awk '
        BEGIN { depth = 0; line_count = 0 }
        /<g/ { depth++; line_count++ }
        /<\/g>/ { 
            depth--; 
            line_count++
            if (depth == 0) { 
                print line_count + '$start_line' - 1
                exit 
            }
        }
        !/<g/ && !/<\/g>/ { line_count++ }
        ' "$temp_file" > end_line.tmp
        
        end_line=$(cat end_line.tmp)
        rm "$temp_file" end_line.tmp
        
        # Create individual SVG file
        {
            cat svg_header.tmp
            sed -n "${start_line},${end_line}p" "$INPUT_SVG"
            cat svg_footer.tmp
        } > "$OUTPUT_DIR/${authority}.svg"
        
        echo "Created: $OUTPUT_DIR/${authority}.svg"
    fi
done < authorities.tmp

# Clean up temp files
rm svg_header.tmp svg_footer.tmp authorities.tmp

echo "Created individual authority SVGs in $OUTPUT_DIR/"
echo "Run ./reassemble-svg.sh to create $GENERATED_SVG"