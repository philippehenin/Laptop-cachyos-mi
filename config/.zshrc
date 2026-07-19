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
export PATH="/home/philippehenin/.local/bin:$PATH"

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

# Developer aliases
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline -n 10"
alias gp="git push"
alias lla="ls -lA --color=auto"
alias ll="ls -l --color=auto"
alias l="ls -CF --color=auto"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Interactive systemd journal error explorer
jerrors() {
  journalctl -p 3 -xb --no-pager | fzf --tac --no-sort \
    --ansi \
    --prompt "Systemd Errors > " \
    --header "Boot Errors (priority 3/err or higher) | Ctrl-R to reload" \
    --bind "ctrl-r:reload(journalctl -p 3 -xb --no-pager)"
}
# Zoxide smart directory jumper
eval "$(zoxide init zsh)"

# History substring search keybindings (Up/Down arrow and vi keys)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

