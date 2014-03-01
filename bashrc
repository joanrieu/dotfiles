[ -z "${BYOBU_PREFIX}" ] && LC_BYOBU=1
source /etc/profile

[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls -lha'
alias rm='rm -I'

function mkcd {
  mkdir "$@" && cd "$@"
}

function pacman-not-owned-files {
  ( sudo find / -not -type d ; (pacman -Qql | egrep -v '/$') ) | sort | uniq -u | egrep -v '^/(home|sys|proc|dev)' | less
}

function pacman-clean-explicits {
  explicits=$(comm -23 <(pacman -Qqe | sort) <(pacman -Sqg base base-devel | sort))
  unneeded=$(LC_ALL=C pacman -Qi $explicits |sed -nre 's/^Name +: (.+)$/\1/p' -e 's/^Description +: (.+)$/\1\noff/p' |xargs -d"\n" dialog --checklist "Select unneeded packages:" 0 0 0 3>&1 1>&2 2>&3)
  if [ -n "$unneeded" ]
  then
    cmd="sudo pacman -D --asdeps $unneeded"
    echo $cmd
    $cmd
  fi
}

fortune -a

PS1=$(
  printf '\[\e[0;%dm\] \\ [\w]\n / \[\e[0m\]\$ ' $(
    case "$HOSTNAME" in
      bluethunder)
        echo 34
        ;;
      srv.fififox.net)
        echo 32
        ;;
      ssh)
        echo 31
        ;;
      *)
        echo 33
        ;;
    esac
  )
)
