#!/bin/bash

# Configuration
POPUP_DURATION_MS=1500  # How long popup stays visible (in milliseconds)
SHOW_POPUP_ON_STOP=false  # Set to true if you want popup to show on stop command
TIMER_FILE="/tmp/playerctl_popup_timer"

# Function to check if any window is fullscreen on active monitor
is_fullscreen() {
    # Check if the focused window is fullscreen (Hyprland specific)
    hyprctl activewindow | grep -E "fullscreen: (1|true)" > /dev/null
}

# Function to execute playerctl command
execute_playerctl() {
    case "$1" in
        "play-pause") playerctl play-pause 2>/dev/null ;;
        "next") playerctl next 2>/dev/null ;;
        "previous") playerctl previous 2>/dev/null ;;
        "stop") playerctl stop 2>/dev/null ;;
        *)
            echo "Usage: $0 {play-pause|next|previous|stop}"
            exit 1
            ;;
    esac
}

# Function to manage popup with extending timer
manage_popup() {
    if is_fullscreen; then
        return 0
    fi
    
    # Get current time in milliseconds
    local current_time=$(date +%s%3N 2>/dev/null || echo $(($(date +%s) * 1000)))
    
    # Calculate end time (current time + duration)
    local end_time=$((current_time + POPUP_DURATION_MS))
    
    # Write end time to file (this extends/resets the timer)
    echo "$end_time" > "$TIMER_FILE"
    
    # Show popup only if not already shown
    if [ ! -f "/tmp/playerctl_popup_visible" ]; then
        hyprpanel t mediamenu
        touch "/tmp/playerctl_popup_visible"
        
        # Start single background timer process
        (
            while [ -f "$TIMER_FILE" ]; do
                local target_end_time=$(cat "$TIMER_FILE" 2>/dev/null || echo 0)
                local now=$(date +%s%3N 2>/dev/null || echo $(($(date +%s) * 1000)))
                
                if [ "$now" -ge "$target_end_time" ]; then
                    # Time's up, close popup and cleanup
                    if [ -f "/tmp/playerctl_popup_visible" ]; then
                        hyprpanel t mediamenu
                        rm -f "/tmp/playerctl_popup_visible"
                    fi
                    rm -f "$TIMER_FILE"
                    break
                fi
                
                # Check every 50ms
                sleep 0.05
            done
        ) &
    fi
}

# Main execution
if [ $# -ne 1 ]; then
    echo "Usage: $0 {play-pause|next|previous|stop}"
    exit 1
fi

# Execute playerctl command immediately (only once)
if execute_playerctl "$1"; then
    # Only show popup if playerctl command was successful
    if [ "$1" != "stop" ] || [ "$SHOW_POPUP_ON_STOP" = "true" ]; then
        (manage_popup) &
    fi
fi

exit 0
