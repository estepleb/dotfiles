#! /usr/bin/env bash

# Toggle mute status
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Get current mute status (yes/no)
mute_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

# Set LED based on mute status
if [ -n "$mute_status" ]; then
    # Muted - turn LED on
    echo 1 | sudo tee /sys/class/leds/platform::micmute/brightness > /dev/null
else
    # Not muted - turn LED off
    echo 0 | sudo tee /sys/class/leds/platform::micmute/brightness > /dev/null
fi
