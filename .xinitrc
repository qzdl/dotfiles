#!/bin/sh
xrdb -merge ~/.Xresources
xrandr --dpi 220
exec i3
