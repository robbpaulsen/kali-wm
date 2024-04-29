#!/usr/bin/env bash

## Modified by: robbpaulsen
## Github:      github.com/robbpaulsen
#
## Rofi:        Desktop App Launcher

dir="$HOME/Playgrounds/Projects/projects-init/rofi-scripts/launchers/ssh-launcher"
theme='ssh-launcher'

## Run
rofi \
	-show ssh \
	-theme ${dir}/${theme}.rasi

# Original work of
## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
