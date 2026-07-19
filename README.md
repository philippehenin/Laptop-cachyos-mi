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
*   **Silent Power Mode**: Added a new custom `silent` profile to `power_profile.py` that disables CPU boost and caps core frequencies at 1.4GHz, keeping the laptop extremely quiet and preventing fan spin-up under light tasks.
*   **Neovim / LazyVim Health Check**: Fixed checkhealth errors and warnings:
    - Installed `lazygit`, `tree-sitter-cli`, and `python-pynvim` via pacman.
    - Corrected Mason's invalid `dockerls` package name to `dockerfile-language-server` in `lazy.lua` and `full_tools.lua`.
    - Enabled the `plugins` folder import in `lazy.lua` so additional tools (Leap, Outline, Prettier, Eslint, Aerial) load correctly.
    - Disabled `luarocks` in lazy.nvim options, and disabled unused Perl, Ruby, and Node.js provider checks in `options.lua`.
*   **Dynamic Configurations**: Generalised the Waybar configuration files to use shell-expanded tilde (`~`) paths instead of hardcoded absolute user home directory paths. Updated `gpu.sh` to automatically detect and query AMD, Nvidia, and Intel GPUs dynamically, keeping the repository generic and preventing breakages across different laptops.
*   **Developer Shell Aliases**: Appended convenient git, file system, and Neovim editor alias commands (e.g. `v`, `gs`, `lla`) to both `.bashrc` and `.zshrc`.
*   **Automatic Power Monitoring**: Integrated the transition-only `power_monitor.sh` background daemon into Hyprland autostart to automatically toggle power profiles based on charger connection.
*   **Catppuccin Mocha Notification Styling**: Styled Mako notifications to use Catppuccin Mocha base, text, and border colors.
*   **Neovim comfort keybindings**: Configured essential comfort mappings (`jk`/`jj` escape, visual indentation, page centering) in Neovim's `keymaps.lua`.
*   **Zoxide Smart Directory Jumper**: Installed `zoxide` and initialized it in both `.bashrc` and `.zshrc` for faster directory navigation.
*   **Zsh History Substring Search Keybindings**: Bound Up/Down arrow keys and vi-mode keys (`k`/`j`) to `zsh-history-substring-search` for intuitive historical command auto-completion.
*   **Interactive Systemd Error Search (`jerrors`)**: Added a convenient `jerrors` function to `.bashrc` and `.zshrc` to browse and fuzzy-find systemd boot errors via `fzf` in real time.

### 2026-07-19
*   **System Update**: Completed a full system package upgrade via `pacman` (with `--overwrite` flags resolving local `npm` module conflicts).
*   **Bluetooth Integration**: Installed `blueman` and added support for launching `blueman-manager` directly on click from the Waybar bluetooth module.
*   **Audio Configuration**: Configured the audio output to route through the HDMI screen (`PL3493WQ`) by default.
*   **Repository Setup**: Created and configured this repository (`Laptop-cachyos-mi`) as the dedicated configuration source for this laptop (`cachyos-mi`).
