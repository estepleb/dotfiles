#!/usr/env/bin bash
paru -S --needed greetd-dms-greeter-git

dms greeter enable
dms greeter sync



/etc/greetd

sed "s/ /,/ /g"


command = "/usr/sbin/dms-greeter --command mangowc -C /etc/greetd/mangowc.conf"




cat >> EOF /etc/greetd/mangowc.conf
# MangoWC greeter configuration


# source=~/.config/mango/monitors.conf
# Primary laptop display (internal)
monitorrule=eDP-1,0.55,1,tile,0,1.67,0,0,2560,1600,90

# External monitor
monitorrule=HDMI-A-1,0.55,1,tile,0,1.0,2560,0,1920,1080,60


source=~/.config/mango/input.conf

# keyboard
repeat_rate=25
repeat_delay=340
numlockon=1
xkb_rules_layout=us
xkb_rules_options=compose:menu
# xkb_rules_options=grp:alt_altgr_toggle,caps:hyper

# Trackpad
disable_trackpad=0
click_method=0 
tap_to_click=1
tap_and_drag=1
drag_lock=1
mouse_natural_scrolling=0
trackpad_natural_scrolling=1
disable_while_typing=1
left_handed=0
middle_button_emulation=0
swipe_min_threshold=1
accel_profile=2
accel_speed=0.0
scroll_method=1


# Cursor Appearance
cursor_size=24
cursor_theme=Bibata-Modern-Classic
cursor_hide_timeout=0


EOF
