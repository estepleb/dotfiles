#!/bin/bash

# Capture the output
output=$(mmsg -gc)

# Parse the output (based on your example)
display=$(echo "$output" | grep -oP '^\S+')
title=$(echo "$output" | grep -oP 'title \K.*' | head -1)
appid=$(echo "$output" | grep -oP 'appid \K.*')

# Send formatted notification
notify-send -e "Active Window" \
	"App ID: $appid\nTitle: $title" --urgency=normal --expire-time=5000
