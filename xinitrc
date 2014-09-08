#!/bin/sh

RUN="systemd-run --user --scope"

exec $RUN enlightenment_start
