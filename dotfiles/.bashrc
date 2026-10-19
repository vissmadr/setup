# shellcheck shell=bash
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim
export EZA_COLORS="da=2:uu=2:"

PS1='[\W]\$ '
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend checkwinsize
set -o vi

# Edit Readline's buffer without Bash's edit-and-execute behavior.
_setup_edit_command() {
  local edit_directory
  edit_directory="$(mktemp -d -t setup-command-XXXXXXXX)" || return
  printf '%s\n' "$READLINE_LINE" > "$edit_directory/command.sh"
  if nvim -n -i NONE "$edit_directory/command.sh" \
    -c 'lua require("keymaps").command_editor()' < /dev/tty > /dev/tty; then
    READLINE_LINE="$(< "$edit_directory/command.sh")"
    READLINE_POINT=${#READLINE_LINE}
  fi
  rm -rf -- "$edit_directory"
}

# Both terminals send this private sequence for Ctrl+1.
bind -m vi-insert -x '"\e[9001~": _setup_edit_command'
bind -m vi-command -x '"\e[9001~": _setup_edit_command'

alias ..='cd ..'
alias grep='grep --color=auto'
alias l='eza -la --time-style=long-iso --sort=name --group-directories-first --icons --git'
alias ll=l
alias v=nvim
alias a='nvim -c "terminal codex" -c startinsert'
alias A=codex
alias f=yazi
alias x=clear
alias b=btop

g() {
  if [[ $# -eq 0 ]]; then
    git
    return
  fi
  local command="$1"
  shift
  case "$command" in
    s) git status "$@" ;;
    b) git branch -a "$@" ;;
    l) git log --oneline "$@" ;;
    L) git log "$@" ;;
    d) git diff "$@" ;;
    D) git diff --staged "$@" ;;
    p) git pull "$@" ;;
    P) git push "$@" ;;
    a)
      if [[ $# -gt 0 ]]; then git add "$@"; else git add .; fi
      ;;
    u) git commit -m update "$@" ;;
    c)
      if [[ $# -eq 0 ]]; then
        echo 'Usage: g c "commit message" [git commit options]' >&2
        return 2
      fi
      local message="$1"
      shift
      git commit -m "$message" "$@"
      ;;
    *) git "$command" "$@" ;;
  esac
}

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd c bash)"
fi
for integration in /usr/share/fzf/key-bindings.bash /usr/share/fzf/completion.bash; do
  # shellcheck source=/dev/null
  [[ ! -r "$integration" ]] || source "$integration"
done
unset integration

# shellcheck source=/dev/null
[[ ! -r "$HOME/.bashrc.local" ]] || source "$HOME/.bashrc.local"
