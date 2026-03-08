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
