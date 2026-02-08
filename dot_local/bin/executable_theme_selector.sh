#!/usr/bin/env bash

# Configuration
THEME_COMMAND="wallust theme list"
CACHE="$HOME/.config/hypr/.cache"
FAVORITES_FILE="${CACHE}/favorites"
THEMES_CACHE="${CACHE}/themes_cache"
CURRENT_THEME="${CACHE}/current_theme"
SCRIPTS="$HOME/.config/hypr/config/scripts"
REFRESH_SCRIPT="${SCRIPTS}/refresh.sh"
CACHE_VALIDITY=3600  # Cache validity in seconds (1 hour)

daynighttoggle="Toggle  Day/ Night"
random="󰑓 Random"
separator="───────────"

# Ensure directories exists
if [[ ! -d "$CACHE" ]]; then
        mkdir -p $"CACHE"
    fi

# Check if cache is still valid
is_cache_valid() {
    local cache="$1"
    if [[ ! -f "$cache" ]]; then
        return 1
    fi
    local cache_age=$(($(date +%s) - $(stat -f%m "$cache" 2>/dev/null || stat -c%Y "$cache")))
    [[ $cache_age -lt $CACHE_VALIDITY ]]
}

# Parse theme list and remove bullet points, removes parenthesis, filter out "list", random, "extra"
get_themes() {
    if is_cache_valid "$THEMES_CACHE"; then
        cat "$THEMES_CACHE"
    else
        local themes=$($THEME_COMMAND | grep -E '^\s*-\s+' | sed 's/^\s*-\s*//' | sed 's/ ([^)]*)//g' |grep -vE '^(extra|list|random)$')
        echo "$themes" > "$THEMES_CACHE"
    fi
}

# Get favorite themes from file
get_favorites() {
    if [[ -f "$FAVORITES_FILE" ]]; then
        cat "$FAVORITES_FILE"
    fi
}

# Build the menu options
build_menu() {
    local themes=$(get_themes)
    local favorites=$(get_favorites)

    # Start with Mode Toggle and Random at the top
    echo "$daynighttoggle"
    echo "$random"
    
    # Add favorites (if any exist)
    if [[ -n "$favorites" ]]; then
        echo "$favorites" | while read -r fav; do
            # Only show if theme still exists
            if echo "$themes" | grep -q "^$fav$"; then
                echo "$fav"
            fi
        done
    fi
    
    # Add separator if we have favorites
    if [[ -n "$favorites" ]]; then
        echo "$separator"
    fi
    
    # Add all remaining themes (excluding favorites and random)
    echo "$themes" | while read -r theme; do
        if ! echo "$favorites" | grep -q "^$theme$"|grep -qe "Extra| l"; then
            echo "$theme"
        fi
    done
}

# Pin theme to favorites
pin_theme() {
    local theme="$1"
    if [[ "$theme" == "$random" || "$theme" == "$separator" ]]; then
        return
    fi
    
    if ! grep -q "^$theme$" "$FAVORITES_FILE" 2>/dev/null; then
        echo "$theme" >> "$FAVORITES_FILE"
    fi
}

# Unpin theme from favorites
unpin_theme() {
    local theme="$1"
    if [[ -f "$FAVORITES_FILE" ]]; then
        grep -v "^$theme$" "$FAVORITES_FILE" > "$FAVORITES_FILE.tmp"
        mv "$FAVORITES_FILE.tmp" "$FAVORITES_FILE"
    fi
}

# Apply theme and run refresh
apply_theme() {
    local theme="$1"

    # Apply the theme

    if [[ "$theme" == "$random" ]]; then
        random_output=$(wallust theme random 2>&1)
        random_theme=$(echo "$random_output" | grep -oP 'randomly selected \K\S+')
        notify-send "Randomly applied $random_theme"
        # Write theme to cache
        echo "wallust theme: $random_theme" > "${CURRENT_THEME}"
    else 
        echo "Applying theme: $theme"
        local error_output
        error_output=$(wallust theme "$theme" 2>&1)

        # Error Handling
        if [[ $? -ne 0 ]]; then
            notify-send -u critical "Theme Error" "Failed to apply theme: $theme"
            return 1
        fi
        
        notify-send "Applied $theme"
        # Write current theme to cache
        echo "wallust theme: $theme" > "${CURRENT_THEME}"
    fi
    
    # Run refresh script if it exists
    if [[ -x "$REFRESH_SCRIPT" ]]; then
        "$REFRESH_SCRIPT"
        echo "Refreshing programs"
    fi
}

# Main rofi selection with custom keybinds
main() {
    local menu=$(build_menu)
    
    # Create rofi with custom keybinds:
    # Alt+p: Pin/Unpin current selection
    # Alt+a: Apply and exit
    local selection=$(echo "$menu" | walker \
        --dmenu \
        -p "Select theme")  
    local exit_code=$?
    
    case $exit_code in
        0)
            # Normal selection (Return key)
            if [[ -n "$selection" ]] && [[ "$selection" != "───────────" ]]; then
                apply_theme "$selection"
            fi
            ;;
        10)
            # Alt+p pressed - Pin/Unpin theme
            if [[ -n "$selection" ]] && [[ "$selection" != "───────────" ]]; then
                if grep -q "^$selection$" "$FAVORITES_FILE" 2>/dev/null; then
                    unpin_theme "$selection"
                    echo "Unpinned: $selection"
                else
                    pin_theme "$selection"
                    echo "Pinned: $selection"
                fi
                # Show menu again
                main
            fi
            ;;
        11)
            # Alt+a pressed - Apply and exit
            if [[ -n "$selection" ]] && [[ "$selection" != "───────────" ]]; then
                apply_theme "$selection"
            fi
            ;;
        1)
            # Escape pressed
            exit 0
            ;;
    esac
}

main
