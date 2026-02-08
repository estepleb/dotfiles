#! /usr/bin/env bash

CACHE="$HOME/.config/hypr/.cache"
THEMES_CACHE="$CACHE/CURRENT_THEME"
SCRIPTS="$HOME/.config/hypr/config/scripts"
REFRESH_SCRIPT="$SCRIPTS/refresh.sh"
wallpaper=$1 

if [[ -z "$wallpaper" ]]; then
    echo "Error: Provide the absolute path of an image file"
    exit 1
fi

# Ensure directories exists
if [[ ! -d "$CACHE" ]]; then
        mkdir -p $"CACHE"
    fi

# Set wallpaper using Swww
echo "Setting background with Swww"
swww img "$wallpaper" --transition-type center

#Generate Wallust color templates with default config
echo "Generating Wallust templates"
wallust run "$wallpaper"
echo "wallust image: $wallpaper" > "$THEMES_CACHE"

sleep 2

# Run refresh script if it exists
if [[ -x "$REFRESH_SCRIPT" ]]; then
    # "$REFRESH_SCRIPT"
    pkill tsumiki | bash "$SCRIPTS/tsumiki_wrapper.sh" -start
    echo "Refreshing programs"
fi

exit
