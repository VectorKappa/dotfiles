#!/bin/dash
xhost + local: ;
swww init;
flameshot &
wayvnc &
dex -a &
dunst &
$HOME/.config/waybar/launcher.sh
