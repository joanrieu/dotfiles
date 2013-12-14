#!/bin/sh

PIDFILE="/run/user/`id -u`/xsession.pid"

echo $$ >"$PIDFILE"
systemctl --user start "graphical@${DISPLAY}.target" && ( kill -STOP $$ ; wait )
rm "$PIDFILE"
