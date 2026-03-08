source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Parallel compilation by default
export MAKEFLAGS="-j$(nproc)"
export CFLAGS="-O3 -march=native -pipe"
export CXXFLAGS="${CFLAGS}"

# Optimize zsh-autosuggestions performance (if loaded by CachyOS config)
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Starship Prompt
eval "$(starship init zsh)"

# FZF initialization
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
export EDITOR=nvim
