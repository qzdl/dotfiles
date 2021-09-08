#!/bin/sh
DIR=$HOME/.guix-profile

setxkbmap -model thinkpad -layout us -option ctrl:nocaps

xrandr --dpi 220

$DIR/bin/xinit -- $DIR/bin/Xorg :0 vt1 -keeptty \
  -configdir $DIR/share/X11/xorg.conf.d \
  -modulepath $DIR/lib/xorg/modules

setxkbmap -model thinkpad -layout us -option ctrl:nocaps

exec emacs
