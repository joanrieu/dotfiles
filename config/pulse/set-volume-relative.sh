#!/bin/bash

pacmd set-sink-volume speakers $(($(pacmd dump |grep 'set-sink-volume speakers' |awk '{ print $3 }') + 65535 * $1/100)) >/dev/null
