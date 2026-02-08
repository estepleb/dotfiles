#!/usr/bin/env bash
tsumiki_script="$HOME/.config/tsumiki/init.sh"

if [[ ! -f "$tsumiki_script" ]]; then
    echo "Error: Tsumiki executable not found. Expected dir: $tsumiki_script"
    exit 1
else
    bash "$tsumiki_script" "$1" & disown
fi

exit 0
