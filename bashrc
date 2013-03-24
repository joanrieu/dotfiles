source /etc/profile

export EDITOR=vim

# Check for an interactive session
[ -z "$PS1" ] && return
[[ "$TERM" == "xterm-termite" ]] && cd && exec tmux

export CC="clang"
export CXX="clang++"
export CXXFLAGS="-std=c++11 -ggdb"
export LD_LIBRARY_PATH="."

eval $(dircolors -b)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'
alias rm='rm -I'

alias owl='LANG=C owl'

function mkcd {
  mkdir "$@" && cd "$@"
}

function pacman-not-owned-files {
  ( find / -not -type d ; (pacman -Qql | egrep -v '/$') ) | sort | uniq -u | egrep -v '^/(home|sys|proc|dev)' | less
}

function pacman-clean-explicits {
  explicits=$(comm -23 <(pacman -Qqe | sort) <(pacman -Sqg base base-devel | sort))
  unneeded=$(LC_ALL=C pacman -Qi $explicits |sed -nre 's/^Name +: (.+)$/\1/p' -e 's/^Description +: (.+)$/\1\noff/p' |xargs -d"\n" dialog --checklist "Select unneeded packages:" 0 0 0 3>&1 1>&2 2>&3)
  if [[ "x$unneeded" != "x" ]] ; then
    cmd="sudo pacman -D --asdeps $unneeded"
    echo $cmd
    $cmd
  fi
}

# Set up prompt
PS1='\[\e[0;31m\] \\ [\w]\n / \[\e[0m\]\$ '

fortune -a
