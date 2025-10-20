#
# ~/.bashrc
#

#--- Vissmadr ---#

########
# Bash #
########

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\W]\$ '

set -o vi

###########
# Aliases #
###########

# general
alias ..='cd ..'
alias grep='grep --color=auto'
alias l='eza -l -a --time-style=long-iso --sort=name --group-directories-first'
alias v='nvim'
alias s='yazi'
alias x='clear'
alias lock='swaylock'

# git
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

############
# Programs #
############

# zoxide
eval "$(zoxide init --cmd c bash)"

# eza
export EXA_COLORS="da=2:uu=2:"

# fzf: In case Ctrl-R doesn't work good
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

#########
# Other #
#########

export EDITOR=nvim
