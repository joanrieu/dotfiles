source /etc/profile
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'
alias rm='rm -I'

function mkcd {
  mkdir "$@" && cd "$@"
}

fortune -a
