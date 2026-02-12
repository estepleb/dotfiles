#!/usr/bin/env bash

completion_file=~/.config/fish/completions/chezmoi.fish

chezmoi completion fish --output="$completion_file"

echo "Writing Chezmoi Completions to $completion_file"
