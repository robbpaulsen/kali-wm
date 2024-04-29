#!/usr/bin/env bash

## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)

dir="$HOME/.config/rofi/launchers/keybinding-helper"
theme="properties"

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
	column -t -s $'\t' | rofi -dmenu -i -markup-rows -no-show-icons \
	-theme ${dir}/${theme}.rasi
