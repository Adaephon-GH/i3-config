#!/bin/bash

set -e

# Pull the mode name from the first command
mode=${1:?Expected mode name as argument}
# Pull the timeout in seconds from the second argument, defaults to 1 second
timeout=${2:-1}

# retrieve timestamp with nanosecond accuracy
timestamp="$(date +%s%N)"

# save the timestamp into a file (probably best on a tmpfs)
mode_file="/tmp/i3-mode-activity.${mode}"
echo "$timestamp" >| "$mode_file"

sleep $timeout

# retrieve timestamp from mode_file
saved_timestamp="$(cat $mode_file)"
    
# if the saved timestamp did not change, leave the mode
if [[ "$saved_timestamp" -eq "$timestamp" ]]; then
    i3-msg mode default
fi
