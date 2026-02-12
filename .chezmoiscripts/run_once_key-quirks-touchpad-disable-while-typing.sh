#! /usr/bin/env bash

# From: https://github.com/rvaiya/keyd/issues/66#issuecomment-985983524

sudo cat <<EOF > /etc/libinput/local-overrides.quirks 
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF
