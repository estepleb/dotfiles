#! /usr/bin/env bash

# Source: https://dolphin-emu.org/docs/guides/how-use-official-gc-controller-adapter-wii-u/#Linux

# Variables
udev='SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"'
file=/etc/udev/rules.d/51-gcadapter.rules
file_contents=$(cat $file)



if [[ ! -f $file ]]; then 
	echo "writing $udev into $file"
	echo "$udev" > $file
else
	echo "$file already exists!"
	echo "file contents are:"
	echo "$file_contents"
	
fi

