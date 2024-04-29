#!/usr/bin/env bash

awk '/^[a-z]/ &&
  last {print $0,"\t\t",last} {last=""} /^#/{last=$0}' "$XDG_CONFIG_HOME"/fzf/scripts/sxhkdrc-showkeys |
	column -t -s $'\t\t' | fzf --color bg:#222222,preview-bg:#333333 --margin 2% --padding 4% \
	--border --border-label="╢ Atajos ╟" --reverse \
	--prompt="Keybindings   : "
