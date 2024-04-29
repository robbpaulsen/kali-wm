#!/usr/bin/env bash

## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)

dir="$HOME/.config/rofi/launchers/typenormal-launcher"
theme='theme'

## Run
rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
