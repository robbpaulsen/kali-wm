#!/usr/bin/env bash

## Modified by: robbpaulsen
## Github:      github.com/robbpaulsen
#
## Rofi:        Desktop App Launcher

dir="$HOME/Playgrounds/Projects/projects-init/rofi-scripts/launchers/fb-launcher"
theme='fb-launcher'

## Run
rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi

# Original work of
## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
