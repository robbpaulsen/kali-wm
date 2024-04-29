#!/usr/bin/env bash
#
# Github : @robbpaulsen

dir="$HOME/.config/rofi/launchers/archiverL"
theme='propiedades'

## Run
rofi \
	-show filebrowser \
	-theme "${dir}/${theme}.rasi"
