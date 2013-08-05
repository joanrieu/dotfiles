#!/bin/bash

old_sink=$(pacmd stat |awk -F': ' '$1 == "Default sink name" { print $2 }')
[[ "$old_sink" == 'headphones' ]] && new_sink='speakers' || new_sink='headphones'
echo "Old sink: $old_sink"
echo "New sink: $new_sink"
pacmd set-default-sink $new_sink >/dev/null

streams=$(pacmd list-sink-inputs |grep index |awk -F': ' '$2 > 1 { print $2 }')
for stream in $streams ; do
        echo "Moved stream: $stream"
        pacmd move-sink-input $stream $new_sink >/dev/null
done

exit
