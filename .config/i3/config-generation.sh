#!/bin/bash

if [[ "$(hostname)" = "panopticon" ]]; then
	  cat ~/.config/i3/config.base ~/.config/i3/config.desktop > ~/.config/i3/config; else
	  cat ~/.config/i3/config.base ~/.config/i3/config.laptop > ~/.config/i3/config
fi
