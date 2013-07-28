#!/bin/bash

set -u
set -e

setxkbmap -option ctrl:nocaps
sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
sudo dpkg-reconfigure -phigh console-setup

if ! grep '^s/keycode  58 = Caps_Lock/keycode  58 = Control/;$' /etc/console-tools/remap &>/dev/null; then 
    echo 's/keycode  58 = Caps_Lock/keycode  58 = Control/;' | sudo tee -a /etc/console-tools/remap
fi
sudo invoke-rc.d console-screen.sh restart
sudo dpkg-reconfigure console-setup
sudo dpkg-reconfigure keyboard-configuration

