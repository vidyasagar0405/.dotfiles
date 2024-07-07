#!/bin/sh
input-remapper-control --command autoload --config-dir /home/vs/.config/input-remapper-2/ &
xrdb merge ~/.Xresources 
xbacklight -set 10 &
nitrogen --restore
xset r rate 200 50 &
picom &
nm-applet &
blueman-applet &
volumeicon &
~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
