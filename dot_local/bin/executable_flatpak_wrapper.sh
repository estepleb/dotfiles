#! /usr/bin/env bash


selected=$(flatpak list | fzf -i)
array=($selected)

echo "Element 0: ${array[0]}"
echo "Element 1: ${array[1]}"

read -p "Are you sure? [Y/n]?" 
