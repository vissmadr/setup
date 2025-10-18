#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\W]\$ '

alias ..='cd ..'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='echo; ls -la; echo'
alias ll='echo; ls -la; echo'
alias v='nvim'
alias s='yazi'
alias k='yazi'
alias j='yazi'
alias x='clear'
alias lock='swaylock'

g() {
  if [[ $# -eq 0 ]]; then
    git
    return
  fi

  local cmd="$1"
  shift

  case "$cmd" in
    s)  git status ;;
    p)  git pull ;;
    a)  git add . ;;
    u)  git commit -m "update" ;;
    P)  git push ;;
    l)  git log ;;
    *)  git "$cmd" "$@" ;;
  esac
}

# Zoxide
eval "$(zoxide init --cmd c bash)"

# In case Ctrl-R fzf doesn't work
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export PATH="$HOME/.local/bin:$PATH"

