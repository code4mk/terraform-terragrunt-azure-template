#!/bin/bash

# Define the source directory (assuming the script is in the root directory)
SOURCE_DIR="modules"

# Get the list of environments by reading the directory names inside the terraform folder
PROJECT_DIR="live"
ENVIRONMENTS=($(ls -d $PROJECT_DIR/*/ | xargs -n 1 basename | grep -v '^common$'))

# Loop through each environment and create symlinks for modules
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="$PROJECT_DIR/$ENV/modules"
    
    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Remove existing symlinks in the target directory
    find "$TARGET_DIR" -type l -delete
    
    # Create symlinks to the modules in the source directory
    for MODULE in "$SOURCE_DIR"/*; do
        MODULE_NAME=$(basename "$MODULE")
        ln -s "../../../$MODULE" "$TARGET_DIR/$MODULE_NAME"
    done
    
    echo "Symlinks created successfully for $ENV environment."
done
