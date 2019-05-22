#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession

# set the default monitor layout on home desktop
if [ $(hostname) == "960-evo" ]; then
    xrandr --output DP-4 --auto --primary --output DVI-D-0 --auto --right-of DP-4
fi


#bash ~/.config/i3/config-generation.sh
#bash ~/git-repos/shell-scripts/set-background.sh
#xset s off
#xset -dpms
#/usr/bin/i3
