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

if [[ "$(hostname)" == "office" ]]; then
    #xrandr --output DP-2 --auto --primary --output DP-1 --auto --above DP-2 --output DP-3 --auto --right-of DP-2 --rotate left
	#xrandr --output DP-4 --auto --primary --output DP-6 --auto --above DP-4 --output DP-0 --auto --right-of DP-4 --rotate left
	echo "hello"
fi


bash ~/.config/i3/config-generation.sh
bash ~/git-repos/shell-scripts/set-background.sh
xset s off
xset -dpms
/usr/bin/i3
