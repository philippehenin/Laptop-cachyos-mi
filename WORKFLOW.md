# Git & GitHub Workflow for Laptop-cachyos-mi

This document outlines the standard workflow for modifying system shells, gitconfigs, shortcuts, and managing versions for your `Laptop-cachyos-mi` configurations.

---

## 1. Modifying & Committing Configurations

All your main system config files are symlinked to this repository under `config/`:
*   `~/.bashrc` -> `config/.bashrc`
*   `~/.zshrc` -> `config/.zshrc`
*   `~/.gitconfig` -> `config/.gitconfig`
*   `~/.local/share/applications/google-chrome.desktop` -> `applications/google-chrome.desktop`

To save changes to these configs:

1.  **Stage modifications**:
    ```bash
    git add .
    ```

2.  **Commit changes**:
    ```bash
    git commit -m "style(shell): configure new aliases and history tweaks"
    ```

---

## 2. Push to GitHub

To push your updates to the remote repository on GitHub:
```bash
git push origin main
```

---

## 3. Creating Version Releases

To tag a version of your configuration state (e.g. `v1.0.0`) using the GitHub CLI:

1.  **Create a release**:
    ```bash
    gh release create v1.0.0 --title "Release v1.0.0" --notes "Initial system configs release (bash, zsh, gitconfig)"
    ```

2.  **Verify release list**:
    ```bash
    gh release list
    ```
