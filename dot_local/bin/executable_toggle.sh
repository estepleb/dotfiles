#!/bin/bash

# Check if a program name was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <program> [arguments...]"
    exit 1
fi

# Get the full command as a string for matching
full_command="$*"

echo "DEBUG: Full command: $full_command"
echo "DEBUG: Checking if running..."

# Check if the command is already running (exclude this script and grep itself)
if pgrep -f "$full_command" | grep -v "^$$\$" > /dev/null; then
    echo "DEBUG: Process found running"
    # Command is running, kill it
    pkill -f "$full_command"
    echo "Killed: $full_command"
else
    echo "DEBUG: Process not found, launching..."
    # Command is not running, launch it
    echo "DEBUG: Executing: $@"
    "$@" > /dev/null 2>&1 &
    disown
    echo "Launched: $full_command"
fi
