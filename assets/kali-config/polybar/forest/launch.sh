#!/usr/bin/env bash

DIR="$HOME/.config/polybar/forest"

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch
polybar -q main -c "$DIR"/config.ini &
