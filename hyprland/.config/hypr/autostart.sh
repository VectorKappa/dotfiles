#!/bin/dash
xhost + local: ;
swww init;
flameshot & disown;
wayvnc &
dex -a &
dunst &
$HOME/.config/waybar/launcher.sh
