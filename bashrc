source /etc/profile
[ -z "$PS1" ] && return
[ -z $TMUX ] && exec ~/.config/control console attach

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'
alias rm='rm -I'
alias dcc='~/.config/control'

function mkcd {
  mkdir "$@" && cd "$@"
}

PS1=$(~/.config/control console setup colors)
fortune -a
