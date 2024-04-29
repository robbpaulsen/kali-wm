#!/usr/bin/env bash

# Modified by: robbpaulsen
# Github:      github.com/robbpaulsen
#
# Rofi:        Desktop App Launcher

dir="$XDG_CONFIG_HOME"/rofi/launchers/d-applauncher
theme='d-applauncher'

## Run
rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi
