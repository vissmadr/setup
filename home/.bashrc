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
    b)  git branch -a ;;
    l)  git log --oneline ;;
    L)  git log ;;
    d)  git diff ;;
    D)  git diff --staged ;;
    p)  git pull ;;
    a)  git add . ;;
    c)  git commit -m "${@:-"update"}" ;;
    P)  git push ;;
    *)  git "$cmd" "$@" ;;
  esac
}

# Zoxide
eval "$(zoxide init --cmd c bash)"

# In case Ctrl-R fzf doesn't work
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export PATH="$HOME/.local/bin:$PATH"

