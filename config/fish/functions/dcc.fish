#!/usr/bin/fish

function dcc-console-attach --description "Tmux session attach/new"
    if test "$TMUX" = ""
        set sessions (tmux list-sessions -F '#{session_id} #{session_attached}' | awk '$2 == 0 { print $1 }')
        if test (count $sessions) -gt 0
            exec tmux attach-session -t $sessions[-1]
        else
            #if test (tmux list-sessions | wc -l) -eq 0
                #dcc-X-login
            #end
            exec tmux
        end
    end
end

function dcc-sd --description "Systemctl user session"
    systemctl --user $argv
end

function dcc-ps --description "User process tree"
    loginctl user-status (whoami)
end

function dcc-X-login --description "X session login"
    dcc-sd set-environment XDG_VTNR=$XDG_VTNR
    dcc-sd start graphical.target
    dcc-sd unset-environment XDG_VTNR
end

function dcc-X-logout --description "X session logout"
    dcc-sd stop X
end

function dcc-music-playpause --description "Play/pause the music"
    ncmpcpp toggle
end

function dcc-music-stop --description "Stop the music"
    ncmpcpp stop
end

function dcc-music-next --description "Next song"
    ncmpcpp next
end

function dcc-music-prev --description "Previous song"
    ncmpcpp prev
end

function dcc-audio-raise --description "Raise the volume"
    ponymix increase 10 >/dev/null
end

function dcc-audio-lower --description "Lower the volume"
    ponymix decrease 10 >/dev/null
end

function dcc-audio-device --description "Query or set the audio output"
    if test "$argv" = ""
        ponymix defaults | awk '$1 == "sink" { print $3 }'
    else
        set -l device "$argv"
        set -l skipped_devices 2
        ponymix set-default -t sink -d $device
        for id in (ponymix list-short -t sink-input | awk '{ print $2 }')
            if test $id -ge $skipped_devices
                ponymix move -t sink-input -d $id $device
            end
        end
    end
end

function dcc-audio-device-toggle --description "Switch between headphones and speakers"
    if test (dcc-audio-device) = headphones
        dcc-audio-device speakers
    else
        dcc-audio-device headphones
    end
end
