#!/bin/dash
xhost + local: ;
swww init;
flameshot & disown;
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
wayvnc & disown;
touchegg & disown;
$HOME/.config/waybar/launcher.sh
