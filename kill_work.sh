#!/usr/bin/env bash

# Function to safely kill a process
kill_process() {
    local process_name=$1

    if pgrep "$process_name" > /dev/null; then
        echo "Killing process: $process_name"
        pkill "$process_name"
        if [ $? -eq 0 ]; then
            echo "$process_name terminated successfully."
        else
            echo "Failed to terminate $process_name."
        fi
    else
        echo "Process $process_name not running."
    fi
}

# Kill specific processes
kill_process "teams-for-linux"
kill_process "remmina"
kill_process "genymotion"

