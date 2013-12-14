#!/bin/bash

function kb_logout() {
  systemctl --user stop X@${DISPLAY}
}

function kb_shell() {
  termite &
}

function kb_shell_attach() {
  tmux list-sessions | dmenu | egrep -o ^[0-9]+ | xargs echo tmux attach-session -t | xargs -0 termite -e &
}

function kb_launcher() {
  dmenu_run &
}

function kb_keyboard_layout_toggle() {
  setxkbmap $(setxkbmap -query |awk -F: -e '/layout: +fr/ { print "us" } /layout: +us/ { print "fr" }')
}

function kb_taskbar_toggle() {
  if systemctl --user is-active tint2@${DISPLAY}
  then
    systemctl --user stop tint2@${DISPLAY}
  else
    systemctl --user start tint2@${DISPLAY}
  fi
}

function kb_music_playpause() {
  ncmpcpp toggle
}

function kb_music_stop() {
  ncmpcpp stop
}

function kb_music_next() {
  ncmpcpp next
}

function kb_music_prev() {
  ncmpcpp prev
}

MUSIC_STEP=50

function kb_music_raise() {
  ncmpcpp volume +$MUSIC_STEP
}

function kb_music_lower() {
  ncmpcpp volume -$MUSIC_STEP
}

AUDIO_STEP=4

function kb_audio_raise() {
  ~/.config/pulse/set-volume-relative.sh +$AUDIO_STEP
}

function kb_audio_lower() {
  ~/.config/pulse/set-volume-relative.sh -$AUDIO_STEP
}

function kb_audio_output_toggle() {
  ~/.config/pulse/switch-sink.sh
}

function kb_audio_output_headphones() {
  if [[ $(pacmd stat | awk -F': ' '$1 == "Default sink name" { print $2 }' ) != 'headphones' ]]
  then
    ~/.config/pulse/switch-sink.sh
  fi
}

"kb_$@"
