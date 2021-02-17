#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus


xrdb -load ~/.Xresources
setxkbmap -option caps:swapescape
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.3

ibus-daemon -d --xim &
sh ~/.fehbg &
compton -b &
sh ~/.panel &
sxhkd &

xss-lock -- i3lock -n -i ~/.background.png &
redshift -l 39.414269:-77.410541 &

export PDFVIEWER=/usr/bin/mupdf
exec cwm
