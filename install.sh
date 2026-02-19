#!/bin/bash

# Configuration directory
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
HOME_DIR="$HOME"

echo "Setting up configuration for $(whoami)..."

# Function to link a file
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            echo "  [SKIP] $dest is already a symlink."
        else
            echo "  [BACKUP] Moving existing $dest to ${dest}.bak"
            mv "$dest" "${dest}.bak"
            ln -s "$src" "$dest"
            echo "  [LINK] Created symlink for $dest"
        fi
    else
        ln -s "$src" "$dest"
        echo "  [LINK] Created symlink for $dest"
    fi
}

# Iterate over files in config directory
shopt -s dotglob
for file in "$CONFIG_DIR"/*; do
    filename=$(basename "$file")
    # Ignore specific files if needed (e.g., .DS_Store, README.md)
    if [[ "$filename" == "README.md" || "$filename" == ".DS_Store" ]]; then
        continue
    fi
    
    # Target path in home directory (assumes filename matches target in home)
    target="$HOME_DIR/$filename"
    
    link_file "$file" "$target"
done

echo "Configuration setup complete."
