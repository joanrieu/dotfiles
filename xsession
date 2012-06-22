#!/bin/bash

exec 1>/dev/null

numlockx &

echo "Xcursor.theme: Oxygen_Black" |xrdb
xsetroot -cursor_name left_ptr
xcompmgr &

amixer set Surround 75%
amixer set Surround off
mpd &

firefox &
screen -U -d -m -S irc weechat-curses &
roxterm --role=irc -T irc -e screen -raAd &
( sleep 30s ; skyped & ) &

i3

mpd --kill
