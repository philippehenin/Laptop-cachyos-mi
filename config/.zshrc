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


# Added by Antigravity CLI installer
export PATH="/home/phe/.local/bin:$PATH"

# FZF optimization (using fd-find and ripgrep)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'

# Deep interactive search (nsearch) using fzf, ripgrep, and bat
# Opens the selected file in Neovim at the specific line number
nsearch() {
  local file
  file=$(fzf --disabled \
             --query "$*" \
             --ansi \
             --prompt "Deep Search > " \
             --bind "start:reload:rg --column --line-number --no-heading --color=always --smart-case -- {q} || :" \
             --bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case -- {q} || :" \
             --delimiter : \
             --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
             --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
             
  if [ -n "$file" ]; then
    local path
    local line
    path=$(echo "$file" | cut -d: -f1)
    line=$(echo "$file" | cut -d: -f2)
    ${EDITOR:-nvim} "$path" +"$line"
  fi
}

