#!/usr/bin/env bash

SDIR="$HOME/.config/rofi/launchers/forest-launcher/style-switcher"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
	-theme $SDIR/properties.rasi \
	<<<" Default| Nord| Gruvbox| Dark| Cherry|")"
case "$MENU" in
*Default) "$SDIR"/styles.sh --default ;;
*Nord) "$SDIR"/styles.sh --nord ;;
*Gruvbox) "$SDIR"/styles.sh --gruvbox ;;
*Dark) "$SDIR"/styles.sh --dark ;;
*Cherry) "$SDIR"/styles.sh --cherry ;;
esac
