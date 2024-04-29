#!/bin/bash
#
# Github : @robbpaulsen

dir="$HOME/.config/rofi/launchers/dialerL"
theme='propiedades'

## Run
rofi \
	-show window \
	-theme "${dir}/${theme}.rasi"
