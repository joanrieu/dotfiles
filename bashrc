source /etc/profile

export EDITOR=vim

# Check for an interactive session
[ -z "$PS1" ] && return
[[ "$TERM" == "xterm" ]] && cd && exec tmux

export CC="clang"
export CXX="clang++"
export CXXFLAGS="-std=c++11 -ggdb"
export LD_LIBRARY_PATH="."

eval $(dircolors -b)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'

alias owl='LANG=C owl'

function mkcd {
  mkdir "$@" && cd "$@"
}

function mkemptyfile {
  : | dd count=1 seek=1 "of=$1" "bs=$2" &>/dev/null
}

function stream {(
  . ~/.config/twitch.tv
  while : ; do
    ffmpeg -f x11grab -s hd1080 -i :0 -f flv rtmp://live.justin.tv/app/$key -v quiet
  done
)}

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
