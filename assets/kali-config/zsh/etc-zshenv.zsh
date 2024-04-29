# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# This is the "/etc/zshenv" file I modified so that all
# free-desktop standard variables usin a zshell can take
# palce, maybe there's a less hackish way of doing it, but
# as always dedvelopers and organizations in linux 
# are not documentation friendly to regular users (like me)
export ZDOTDIR=$HOME/.config/zsh
