#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\W]\$ '

alias ..='cd ..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='echo; ls -la; echo'
alias ll='echo; ls -la; echo'
alias v='nvim'
alias c='clear'
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

# In case Ctrl-R fzf doesn't work
# source /usr/share/fzf/key-bindings.bash
# source /usr/share/fzf/completion.bash
