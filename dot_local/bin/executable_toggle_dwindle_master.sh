#! /usr/bin/env bash

HYPR_DIR=$HOME/.config/hypr/
HYPR_CACHE=${HYPR_DIR}/.cache
CACHE_FILE=${HYPR_CACHE}/hyprland_current_layout

if [[ ! -d "$HYPR_CACHE" ]]; then
    mkdir -p "${HYPR_CACHE}"
fi

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
	hyprctl keyword general:layout dwindle

	hyprctl keyword unbind SUPER,PERIOD
	hyprctl keyword unbind SUPER,COMMA
	hyprctl keyword unbind SUPER,N
	hyprctl keyword unbind SUPER,M
	hyprctl keyword bind SUPER,PERIOD,cyclenext
	hyprctl keyword bind SUPER,COMMA,cyclenext,prev
	hyprctl keyword bind SUPER,M,togglesplit
    notify-send -e -u low "Swtiched to: Dwindle Layout"
    echo "dwindle" > ${CACHE_FILE}
	;;
"dwindle")
	hyprctl keyword general:layout master

	hyprctl keyword unbind SUPER,PERIOD
	hyprctl keyword unbind SUPER,COMMA
	hyprctl keyword unbind SUPER,N
	hyprctl keyword unbind SUPER,M
	hyprctl keyword bind SUPER,PERIOD,layoutmsg,cyclenext
	hyprctl keyword bind SUPER,COMMA,layoutmsg,cycleprev
    hyprctl keyword bind SUPER,M,layoutmsg,swapwithmaster
    notify-send -e -u low "Switched to: Master Layout"
    echo "master" > ${CACHE_FILE}
	;;
*) ;;

esac
