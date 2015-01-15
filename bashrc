source /etc/profile
[ -z "$PS1" ] && return
[ -z "$TMUX" ] || exec fish

alias f='exec fish'
fortune -a
