#!/usr/bin/env sh

## Add this to your wm startup file.

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch
# Left bar
polybar start-button --config=$HOME/.config/polybar/current.ini &

# Keys-Help Bar
polybar keysbar -c $HOME/.config/polybar/current.ini &

# Right bar
polybar ethernet-bar -c $HOME/.config/polybar/current.ini &
polybar htb_status -c $HOME/.config/polybar/current.ini &
polybar updater -c $HOME/.config/polybar/current.ini &
polybar target -c $HOME/.config/polybar/current.ini &

# Center bar
polybar primary -c ~/.config/polybar/workspace.ini &
