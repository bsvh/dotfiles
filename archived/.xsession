#!/bin/sh

xrdb -load ~/.Xresources

xset fp rehash
xset -b

setxkbmap -option compose:ralt
#setxkbmap -option caps:swapescape
setxkbmap -option grp:switch,grp:shift_toggle,grp_led:scroll 'us,ar'
