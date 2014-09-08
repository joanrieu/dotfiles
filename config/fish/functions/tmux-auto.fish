function tmux-auto --description "Tmux session attach/new"
    if test "$TMUX" = ""
        set sessions (tmux list-sessions -F '#{session_id} #{session_attached}' 2>/dev/null | awk '$2 == 0 { print $1 }')
        if test (count $sessions) -gt 0
            exec tmux attach-session -t $sessions[-1]
        else
            exec tmux
        end
    end
end
