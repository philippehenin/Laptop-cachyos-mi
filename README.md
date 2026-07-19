# Laptop Configuration

This repository manages the configuration and setup for this laptop.

## Structure

*   **`config/`**: Contains configuration files (dotfiles) for various applications.
    *   `.bashrc`: Bash shell configuration
    *   `.zshrc`: Zsh shell configuration
    *   `.gitconfig`: Git configuration
*   **`applications/`**: Contains `.desktop` files for optimized application launches (e.g., Google Chrome with GPU acceleration).
*   **`install.sh`**: The main setup script to symlink configurations and install software.
*   **`WORKFLOW.md`**: Guide for saving configurations, committing, pushing, and releasing.

---

## Usage

Run the installation script to apply configurations:
```bash
./install.sh
```

---

## Workflow Documentation

For instructions on committing modifications, pushing updates to GitHub, and managing releases, see:
*   [WORKFLOW.md](WORKFLOW.md)

---

## Updates & History

### 2026-07-20
*   **Path Correction**: Fixed the environment path installation for the `agy` CLI in `.bashrc` and `.zshrc` to point to `/home/philippehenin/.local/bin` instead of the incorrect `/home/phe/.local/bin`.
*   **GPU Monitoring**: Rewrote the Waybar GPU monitoring script (`gpu.sh`) to support AMD Radeon Vega (Renoir) integrated graphics instead of the old Intel/Nvidia template.
*   **Power Management**: Rewrote the Waybar power profile script (`power_profile.py`) to control CPU governors via `cpupower` directly (since the Ryzen CPU lacks CPPC BIOS support, meaning `power-profiles-daemon` could not support the `performance` governor). Disabled the conflicting `power-profiles-daemon.service`.

### 2026-07-19
*   **System Update**: Completed a full system package upgrade via `pacman` (with `--overwrite` flags resolving local `npm` module conflicts).
*   **Bluetooth Integration**: Installed `blueman` and added support for launching `blueman-manager` directly on click from the Waybar bluetooth module.
*   **Audio Configuration**: Configured the audio output to route through the HDMI screen (`PL3493WQ`) by default.
*   **Repository Setup**: Created and configured this repository (`Laptop-cachyos-mi`) as the dedicated configuration source for this laptop (`cachyos-mi`).
