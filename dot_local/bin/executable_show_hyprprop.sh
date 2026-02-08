#!/usr/bin/env bash

# Capture the output of hyprprop
output=$(hyprprop)

# Create a temporary file to store the output
temp_file=$(mktemp)
echo "$output" > "$temp_file"

# Launch alacritty with floating window class to display the output
alacritty --title hyprprop \
  -e bash -c "cat '$temp_file' && echo -e '\n\nPress any key to close...' && read -n 1 && rm '$temp_file'"
