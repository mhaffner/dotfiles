#!/bin/bash

if [[ "$(hostname)" = "960-evo" ]] || [[ "$(hostname)" == office ]]; then
	  cat ~/.config/i3/config.base ~/.config/i3/config.desktop > ~/.config/i3/config; else
	  cat ~/.config/i3/config.base ~/.config/i3/config.laptop > ~/.config/i3/config
fi
