#!/bin/bash
set +e

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango >/dev/null 2>&1

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango >/dev/null 2>&1

# Start systemd mango session target, to autostart other systemd services
systemctl --user start mango-session.target

# Start DMS shell
dms run -d 

# Start kdeconnect daemon
kdeconnectd

# keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# sync clipboard content across x11 and multiple wayland sessions
# clipboard-sync

# clipboard content manager
# wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# Start foot daemon
# foot --server

# walker --gapplication-service >/dev/null 2>&1

# gsettings set org.gnome.desktop.interface text-scaling-factor 1.6

# xwayland dpi scale
# echo "Xft.dpi: 160" | xrdb -merge
# xrdb merge ~/.Xresources >/dev/null 2>&1
