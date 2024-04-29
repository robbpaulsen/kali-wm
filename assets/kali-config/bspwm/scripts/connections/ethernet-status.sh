#!/bin/sh

echo "%{F#2495e7}󰈀 %{F#ffffff}$(/usr/bin/hostname -I | awk '{print $1}')%{u-}"
