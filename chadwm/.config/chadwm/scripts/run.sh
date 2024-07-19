#!/bin/sh
input-remapper-control --command autoload --config-dir /home/vs/.config/input-remapper-2/ &
xrdb merge ~/.Xresources 
xbacklight -set 10 &
/usr/bin/nitrogen --set-zoom-fill --random /home/vs/Pictures/wallpapers/
xset r rate 200 50 &
picom &
dash ~/.config/chadwm/scripts/bar.sh &
eww -c /home/vs/dotfiles/eww/.config/eww/bar open bar
nm-applet &
blueman-applet &
. /home/vs/run_volumeicon.sh
dwm
betterlockscreen -u /home/vs/Pictures/wallpapers/
#while type dwm >/dev/null; do dwm && continue || break; done
