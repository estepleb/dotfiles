#!/user/bin/env fish

set ws (hyprctl activewindow -j | jq -r ".workspace.name"); string match -q "special:*" $ws; and hyprctl dispatch togglespecialworkspace (string replace "special:" "" $ws)


# hyprctl dispatch closewindow (WindowCLASS) kill rofi if rofi is open but not currently focused
# if current focus is on special, take name of special and toggle it off
