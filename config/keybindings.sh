#!/bin/bash

function kb_logout() {
  systemctl --user stop X
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

MUSIC_VOLUME_STEP=50

function kb_music_raise() {
  ncmpcpp volume +$MUSIC_VOLUME_STEP
}

function kb_music_lower() {
  ncmpcpp volume -$MUSIC_VOLUME_STEP
}

AUDIO_VOLUME_STEP=4

function kb_audio_raise() {
  ponymix increase -d speakers $AUDIO_VOLUME_STEP
}

function kb_audio_lower() {
  ponymix decrease -d speakers $AUDIO_VOLUME_STEP
}

function audio_is_headphones() {
  [[ $(ponymix defaults | awk '/^sink / { print $3 }') == "headphones" ]]
}

function kb_audio_output_toggle() {
  audio_is_headphones && device="speakers" || device="headphones"
  ponymix set-default -t sink -d $device
  skipped_devices=2
  ponymix list-short -t sink-input | awk '$2 >= '$skipped_devices' { print "ponymix move -t sink-input -d "$2" '$device'" }' | sh
}

function kb_audio_output_headphones() {
  audio_is_headphones || kb_audio_output_toggle
}

"kb_$@"
