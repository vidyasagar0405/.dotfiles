#!/bin/sh
input-remapper-control --command autoload --config-dir /home/vs/.config/input-remapper-2/ &
xrdb merge ~/.Xresources 
xbacklight -set 10 &
nitrogen --restore
xset r rate 200 50 &
picom &
~/.config/chadwm/scripts/bar.sh &
nm-applet &
blueman-applet &
. /home/vs/run_volumeicon.sh
dwm
#while type dwm >/dev/null; do dwm && continue || break; done
