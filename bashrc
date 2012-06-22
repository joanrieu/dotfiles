source /etc/profile

export EDITOR=vim

export CC="clang"
export CXX="clang++"
export CXXFLAGS="-std=c++11 -ggdb"
export LD_LIBRARY_PATH="."

# Check for an interactive session
[ -z "$PS1" ] && return

eval $(dircolors -b)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'

alias qemu-kvm='qemu-system-x86_64 -enable-kvm -m 1024'
alias owl='LANG=C owl'

function mkcd {
  mkdir "$@" && cd "$@"
}

function mkemptyfile {
  : | dd count=1 seek=1 "of=$1" "bs=$2" &>/dev/null
}

function stream {(
  while : ; do
    ffmpeg -f x11grab -s hd1080 -i :0 -f flv rtmp://live.justin.tv/app/live_28539994_rdXM4z5vzbUdqxAlKWC6xbqsPUwaiP -v quiet
  done
)}

function streamstop {
  kill -HUP $(cat .streampid) && rm .streampid
}

function pacman-not-owned-files {
  ( find / -not -type d ; (pacman -Qql | egrep -v '/$') ) | sort | uniq -u | egrep -v '^/(home|sys|proc|dev)' | less
}

# Set up prompt
PS1='\[\e[0;31m\] \\ [\w]\n / \[\e[0m\]\$ '

fortune -a
