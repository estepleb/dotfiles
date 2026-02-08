#! /usr/bin/env bash

sudo cat <<EOF > /etc/libinput/local-overrides.quirks 
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF
