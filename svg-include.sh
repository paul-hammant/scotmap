#!/bin/bash

# Alternative approach: Create a template-based SVG with include markers
# This creates a more maintainable system using placeholder substitution

set -e

INPUT_SVG="scottish-local-authorities-with-labels-and-links.svg"
OUTPUT_DIR="authorities"
TEMPLATE_SVG="scotland-template.svg"
GENERATED_SVG="scotland-generated.svg"

# Create template with include markers
echo "Creating template with include markers..."
{
    # Copy header and background
    sed -n '1,/id="background"/p' "$INPUT_SVG" | head -n -1
    sed -n '/id="background"/,/^[[:space:]]*<\/g>$/p' "$INPUT_SVG"
    
    # Add include markers for each authority
    grep '<g id=' "$INPUT_SVG" | grep -v 'scottish-local-authorities-text\|background' | while IFS= read -r line; do
        authority=$(echo "$line" | sed 's/.*id="\([^"]*\)".*/\1/')
        echo "        <!-- #include authorities/${authority}.svg -->"
    done
    
    # Close the main group and SVG
    echo "    </g>"
    echo "</svg>"
    
} > "$TEMPLATE_SVG"

echo "Created template: $TEMPLATE_SVG"
echo "Use process-includes.sh to generate final SVG"