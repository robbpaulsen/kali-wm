#!/bin/sh
yad --title="Bspwm keybindings:" \
	--no-buttons --geometry=984x744-50-500 --list --column=key: --column=description: "alt + 󱊫" "Show keybindings help" \
	"super  + Return 󰌑" "terminal emulator" \
	"ctrl + alt + Return 󰌑" "Open floating Terminal" \
	"super  + 󱁐" "program launcher" \
	"ctrl + super  + p" "Picom troubleshooter, restart it if necessary" \
	"super  + 󱊷" "make sxhkd reload its configuration files:" \
	"super  + 󰘶 + {q,r}" "quit/restart bspwm" \
	"super  + k" "close and kill" \
	"super  + m" "alternate between the tiled and monocle layout" \
	"super  + y" "send the newest marked node to the newest preselected node" \
	"super  + g" "swap the current node and the biggest window" \
	"super  + {t, 󰘶 + t,s,f}" "set the window state" \
	"super  + ctrl + {m,x,y,z}" "set the node flags" \
	"super  + {_, 󰘶 + }{,,,}" "focus the node in the given direction" \
	"super  + {p,b,󰸥,}" "focus the node for the given path jump" \
	"super  + {_, 󰘶 + }c" "focus the next/previous window in the current desktop" \
	"super  + bracket{left,right}" "focus the next/previous desktop in the current monitor" \
	"super  + {grave,tab 󰌒}" "focus the last node/desktop" \
	"super  + {o,i}" "focus the older or newer node in the focus history" \
	"super  + {_, 󰘶 + }{1-9,0}" "focus or send to the given desktop" \
	"super  + ctrl + alt + {,,,}" "preselect the direction" \
	"super  + ctrl + alt + {1-9}" "preselect the ratio" \
	"super  + ctrl + alt +e 󱁐" "cancel the preselection for the focused node" \
	"super  + ctrl + shift 󰘶 + 󱁐" "cancel the preselection for the focused desktop" \
	"super  + ctrl + {,,,}" "move a floating window" \
	"super  + alt + {,,,}" "Custom move/resize" \
	"super  + w" "Open Firefox Browser" \
	"super  + e" "Open Graphical File Manager" \
	"super  + n" "Open Terminal Text Editor " \
	"super  + r" "Open Terminal File Manager" \
	"super  + ctrl + 󰘶 + e" "Quick File Browser" \
	"alt + tab 󰌒" "Rofi Window Switcher" \
	"super  + shift 󰘶 + 󱊬" "Rofi SSh HostBook" \
	"super  + shift 󰘶 + 󱊫" "Check Your Keybindings" \
	"super  + l" "Fancy lock screen 󰷛" \
	"super  + ctrl + 󰘶 + {}" "Next Wallpaper" \
	"super  + ctrl + 󰘶 + {}" "Previous WallPaper" \
	"super  + ctrl + alt + 󱊳" "Manually kill the bar"
