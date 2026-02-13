#!/usr/bin/env bash

# Explicit packages (ones you intentionally installed)
pacman -Qqen > pkglist.txt

# AUR packages separately
pacman -Qqem > aurlist.txt


# List all installed flatpaks
flatpak list --app --columns=application > flatpaks.txt
