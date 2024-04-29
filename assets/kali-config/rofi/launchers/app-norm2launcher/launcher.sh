#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/app-norm2launcher"
theme='properties'

rofi \
	-no-lazy-grab \
	-disable-history \
	-modi "drun" -show drun \
	-theme ${dir}/${theme}.rasi \
	-location 1 \
	-xoffset 75 \
	-yoffset 10
