#!/usr/bin/env bash

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
	column -t -s $'\t' |
	rofi -c $XDG_CONFIG_HOME/rofi/config2.rasi -dmenu -i -p "keybindings:" -markup-rows -no-show-icons -font "JetBrains Mono 10" -width 900 -lines 50 -yoffset 80
