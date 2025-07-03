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

cat authorities/aberdeenshire.svg >> $OUTPUT_SVG
cat authorities/angus.svg >> $OUTPUT_SVG
cat authorities/argyll-and-bute.svg >> $OUTPUT_SVG
cat authorities/clackmannanshire.svg >> $OUTPUT_SVG
cat authorities/dumfries-and-galloway.svg >> $OUTPUT_SVG
cat authorities/dunbarton.svg >> $OUTPUT_SVG
cat authorities/east-ayrshire.svg >> $OUTPUT_SVG
cat authorities/east-dunbartonshire.svg >> $OUTPUT_SVG
cat authorities/mid-and-east-lothian.svg >> $OUTPUT_SVG
cat authorities/edinburgh.svg >> $OUTPUT_SVG
cat authorities/falkirk.svg >> $OUTPUT_SVG
cat authorities/fife.svg >> $OUTPUT_SVG
cat authorities/glasgow.svg >> $OUTPUT_SVG
cat authorities/highland.svg >> $OUTPUT_SVG
cat authorities/inverclyde-renfrewshire-east-renfrewshire.svg >> $OUTPUT_SVG
cat authorities/moray.svg >> $OUTPUT_SVG
cat authorities/na-h-eileanan-siar.svg >> $OUTPUT_SVG
cat authorities/north-ayrshire.svg >> $OUTPUT_SVG
cat authorities/north-lanarkshire.svg >> $OUTPUT_SVG
cat authorities/orkney-islands.svg >> $OUTPUT_SVG
cat authorities/perth-and-kinross.svg >> $OUTPUT_SVG
cat authorities/scottish-borders.svg >> $OUTPUT_SVG
cat authorities/shetland-islands.svg >> $OUTPUT_SVG
cat authorities/south-ayrshire.svg >> $OUTPUT_SVG
cat authorities/south-lanarkshire.svg >> $OUTPUT_SVG
cat authorities/west-lothian.svg >> $OUTPUT_SVG

cat coastline.svg >> $OUTPUT_SVG

echo "</ns0:svg>" >> $OUTPUT_SVG

echo "Generated $OUTPUT_SVG with embedded authority SVGs"
echo "File size: $(du -h "$OUTPUT_SVG" | cut -f1)"