#!/bin/dash
xhost + local: ;
swww init;
flameshot & disown;
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
wayvnc & disown;
$HOME/.config/waybar/launcher.sh
