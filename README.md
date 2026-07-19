# Laptop Configuration

This repository manages the configuration and setup for this laptop.

## Structure

- **`config/`**: Contains configuration files (dotfiles) for various applications.
  - `.bashrc`: Bash shell configuration
  - `.zshrc`: Zsh shell configuration
  - `.gitconfig`: Git configuration
- **`applications/`**: Contains `.desktop` files for optimized application launches (e.g., Google Chrome with GPU acceleration).
- **`install.sh`**: The main setup script to symlink configurations and install software.

## Usage

Run the installation script to apply configurations:

```bash
./install.sh
```

## Updates & History

### 2026-07-19
- **System Update**: Completed a full system package upgrade via `pacman` (with `--overwrite` flags resolving local `npm` module conflicts).
- **Bluetooth Integration**: Installed `blueman` and added support for launching `blueman-manager` directly on click from the Waybar bluetooth module.
- **Audio Configuration**: Configured the audio output to route through the HDMI screen (`PL3493WQ`) by default.
- **Repository Setup**: Created and configured this repository (`Laptop-cachyos-mi`) as the dedicated configuration source for this laptop (`cachyos-mi`).
