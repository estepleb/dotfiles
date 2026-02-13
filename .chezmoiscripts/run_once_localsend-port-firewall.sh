#!/usr/bin/env bash


echo "Opening port on firewall for Localsend"


echo "Opening port 53317 for TCP traffic for Localsend"

sudo ufw allow 53317/tcp

echo "Opening port 53317 for UDP traffic for Localsend"
sudo ufw allow 53317/udp

echo "Reloading firewall"
sudo ufw reload
