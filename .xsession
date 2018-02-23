#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession

bash ~/.config/i3/config-generation.sh
bash ~/git-repos/shell-scripts/set-background.sh
xset s off
xset -dpms
