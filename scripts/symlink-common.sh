#!/bin/bash

# Title
echo "🔄 Starting common-*.tf symlink creation..."
echo "--------------------------------------------"

# Define source and project directory
SOURCE_DIR="live/common"
PROJECT_DIR="live"

# Detect environments (exclude 'common')
ENVIRONMENTS=($(ls -d $PROJECT_DIR/*/ | xargs -n 1 basename | grep -v '^common$'))

# Loop through each environment
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="$PROJECT_DIR/$ENV"
    echo "🔧 Processing environment: $ENV"
    
    # Clean old symlinks
    echo "🧹 Removing existing common-*.tf symlinks from $TARGET_DIR"
    find "$TARGET_DIR" -maxdepth 1 -type l -name "common-*.tf" -exec rm -f {} \;

    # Create new symlinks
    echo "🔗 Creating new symlinks from $SOURCE_DIR"
    for COMMON_FILE in "$SOURCE_DIR"/common-*.tf; do
        FILE_NAME=$(basename "$COMMON_FILE")
        SYMLINK_PATH="$TARGET_DIR/$FILE_NAME"
        ln -s "../common/$FILE_NAME" "$SYMLINK_PATH"
        echo "   ✅ Linked $FILE_NAME → ../common/$FILE_NAME"
    done

    echo "✅ Finished $ENV"
    echo "--------------------------------------------"
done

echo "🎉 All symlinks created successfully!"
