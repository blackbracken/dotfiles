#!/bin/zsh

# utils for interactive zsh

eval "$(starship init zsh)"
eval "$(mise activate zsh)"

precmd() {
  print -Pn "\e]0;${PWD##*/}\a"
}

# history
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=200000
export SAVEHIST=200000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# aliases
alias ":q"="exit"
alias "ls"="eza -l"
alias "vim"="nvim"
alias "hist"="history -nr 1 | fzf"
alias "repo"='cd "$(ghq list -p | fzf)"'
alias "gsf"="git branch -a | fzf | sed 's/remotes\/origin\///g' | xargs git switch"
alias "ghqcd"='p=$(ghq list -p | fzf) && [ -n "$p" ] && cd "$p"'

# npx
alias "ccusage"="npx ccusage"
alias "difit"="npx difit"
