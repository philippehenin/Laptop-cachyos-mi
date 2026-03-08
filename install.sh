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

# Applications directory
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/applications"
APP_TARGET_DIR="$HOME/.local/share/applications"

# Ensure application directory exists
if [ -d "$APP_DIR" ]; then
    echo "Setting up application shortcuts..."
    mkdir -p "$APP_TARGET_DIR"
    
    # Iterate over files in applications directory
    for file in "$APP_DIR"/*.desktop; do
        [ -e "$file" ] || continue
        filename=$(basename "$file")
        target="$APP_TARGET_DIR/$filename"
        
        link_file "$file" "$target"
    done
fi

# Cursor theme installation
CURSOR_THEME="GoogleDot-Blue"
CURSOR_URL="https://github.com/ful1e5/Google_Cursor/releases/download/v2.0.0/GoogleDot-Blue.tar.gz"
ICONS_DIR="$HOME/.icons"

if [ ! -d "$ICONS_DIR/$CURSOR_THEME" ]; then
    echo "Installing $CURSOR_THEME cursor theme..."
    mkdir -p "$ICONS_DIR"
    curl -L "$CURSOR_URL" -o "/tmp/$CURSOR_THEME.tar.gz"
    tar -xzf "/tmp/$CURSOR_THEME.tar.gz" -C "$ICONS_DIR"
    rm "/tmp/$CURSOR_THEME.tar.gz"
    
    # Set the theme if on GNOME
    if command -v gsettings >/dev/null; then
        echo "Setting cursor theme to $CURSOR_THEME..."
        gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"
    fi
else
    echo "  [SKIP] $CURSOR_THEME cursor theme is already installed."
fi

echo "Configuration setup complete."
