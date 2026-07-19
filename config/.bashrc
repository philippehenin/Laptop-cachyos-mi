#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# History optimizations
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

# Parallel compilation by default
export MAKEFLAGS="-j$(nproc)"
export CFLAGS="-O3 -march=native -pipe"
export CXXFLAGS="${CFLAGS}"

# Starship Prompt
eval "$(starship init bash)"

# FZF initialization
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
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


