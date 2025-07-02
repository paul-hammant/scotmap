# What is this?

An SVG map of the local authorities of Scotland. Click on the label for the local authority and go to a 
page for that. No pages for this in this demo (all 404 right now).

For your use, you'd copy in scottish-local-authorities-with-labels-and-links.svg and scottish-local-authorities.svg 
to your solution, have something like the index.html I have here, and ensure that the hyperlinks go to something 
meaningful.

## SVG Splitting and Reassembly

This repository includes scripts to split the main Scotland SVG into individual authority files and reassemble them:

### Usage

1. **Split the main SVG into individual authority files:**
   ```bash
   ./split-svg.sh
   ```
   This creates an `authorities/` directory with 32 individual SVG files (one per Scottish local authority).

2. **Generate a reassembled SVG using the include system:**
   ```bash
   ./svg-include.sh      # Creates template with include markers
   ./process-includes.sh # Processes includes to generate final SVG
   ```
   This creates `scotland-generated.svg` (24K) that's functionally identical to the original but assembled from individual components.

### Alternative Reassembly

You can also use the direct reassembly method:
```bash
./reassemble-svg.sh
```

### Benefits

- **Modular editing**: Edit individual authority SVGs independently
- **Maintainable**: Template-based system with `<!-- #include authorities/authority.svg -->` markers
- **Browser-ready**: Generated SVG maintains all original functionality and links
- **Smaller files**: Individual authority files are easier to work with than the full 353KB original 

To me, this was a 2024 experiment to see how far AIs could go with work on SVGs, but it could be useful to someone
in Scotland as is.

# See this on GitHub Pages

https://paul-hammant.github.io/scotmap/

# Work done 

Image in here was taken from:

1. https://en.m.wikipedia.org/wiki/File:NUTS_3_regions_of_Scotland_map.svg (2.92 MB)
2. edited to remove the numerical legends for 33 localities
3. That shown in a browser
4. screen-capped back to png (125 KB, 676 x 900 pixels)
5. Taken into a PNG to SVG tracing tool with "extra smoothing turned on"
6. That SVG fixed up by hand quite a bit - layering, some deletes where what was deleted wasn't apparent to the eye (353 KB, 144KB zipped)
7. Handed to ChatGPT's "GPT4o" LLM for additional path simplification (246 KB, 93 KB zipped). 

TODO: the navy blue coastline is also between localities inland too and should not be. Or it shouldn't be blue. 
Those inland gaps could be simplified with squares and ovals that are behind the locality outlines. I have commented 
out the shapes at the end of the svg file so they can't be seen, but ideally I would ask an AI to remove sections of 
the coastline (ID) that are coinciding with the gaps-between-localities (ID). Sept 2024: AIs are considering this task 
took big.

# Copyright

From the NUTS-3 SVG on wikipedia:

    "This file is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license.
    Attribution: Dr Greg, Nilfanion & XrysD. Contains Ordnance Survey data © Crown copyright and 
    database right 2011"

As transformations have been applied to an original and only minor hand edits, the PNG and SVG in here should be considered the same license and copyright.

The index.html and the scottish-local-authorities-with-labels-and-links.svg it cites are copyright Paul Hammant, and Creative Commons Attribution-Share Alike 3.0 license.

