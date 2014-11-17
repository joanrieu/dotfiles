if test "$XDG_VTNR" -eq 2
    set XDG_VTNR
    exec startx
else
    tmux-auto
end
