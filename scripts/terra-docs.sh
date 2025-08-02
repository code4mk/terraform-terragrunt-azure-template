#!/bin/bash

set -e

MODULES_DIR="modules"

# Find all folders with a main.tf file
find "$MODULES_DIR" -type f -name "main.tf" | while read -r tf_file; do
    dir="$(dirname "$tf_file")"
    echo "📁 Processing: $dir"
    
    (
        cd "$dir"
        terraform-docs markdown table . \
            --output-file README.md \
            --output-mode inject
    )
done