# Profile file like .profile
# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
export XDG_DESKTOP_DIR=$HOME/Desktop
export XDG_DOWNLOAD_DIR=$HOME/Downloads
export XDG_TEMPLATES_DIR=$HOME/Templates
export XDG_PUBLICSHARE_DIR=$HOME/Public
export XDG_DOCUMENTS_DIR=$HOME/Documents
export XDG_MUSIC_DIR=$HOME/Music
export XDG_PICTURES_DIR=$HOME/Pictures
export XDG_VIDEOS_DIR=$HOME/Videos
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export LIBGUESTFS_BACKEND=direct
export ANDROID_USER_HOME=$HOME/.local/share/android
export ANSIBLE_HOME=$HOME/.local/share/ansible
export CHEZMOI_SOURCE_PATH="$(chezmoi source-path)"
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export DOTNET_CLI_HOME=$HOME/.local/share/dotnet
export HISTFILE=$XDG_STATE_HOME/bash/history
export GOROOT=$HOME/.local/share/.go
export GOPATH=$HOME/.local/share/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
export GO111MODULE=on
export XCURSOR_PATH=/usr/share/icons:$HOME/.local/share/icons
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
export MINIKUBE_HOME=$HOME/.local/share/minikube
export TERMINFO=$HOME/.local/share/terminfo
export TERMINFO_DIRS=$HOME/.local/share/terminfo:/usr/share/terminfo
export PARALLEL_HOME=$XDG_CONFIG_HOME/parallel
export RUSTUP_HOME=~/.local/share/rustup
export ZSH=~/.local/share/oh-my-zsh
export ZSH_CUSTOM=~/.local/share/oh-my-zsh/custom
export ZDOTDIR=/home/heimdal/.config/zsh
export PATH=$PATH:$HOME/.local/bin
export CARGO_HOME=$HOME/.local/share/cargo
export BIN_DIR=$BIN_DIR:-$CARGO_DEFAULT_BIN
export CARGO_DEFAULT_BIN=$CARGO_HOME/bin
export PATH=$PATH:$HOME/.local/share/cargo/bin
export TERM=xterm-256color
export SHELL=/usr/bin/zsh
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export COLORTERM=truecolor
export LIBVIRT_DEFAULT_URI=qemu:///system
export JAVA_HOME=/lib/jvm/bellsoft-java17-full.x86_64
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export W3M_DIR="$HOME/.local/share"/w3m
export GEM_HOME="$HOME/.local/share"/gem
export PIPX_HOME_DIR=$HOME/.local/pipx/venvs
export PIPX_BIN_DIR=$HOME/.local/pipx/bin
export PATH=$PATH:/var/lib/flatpak/exports/share
export PATH=$PATH:/home/heimdal/.local/share/flatpak/exports/share
export HISTCONTROL=ignoredups:erasedups
export GH_EDITOR=nvim
export GIT_EDITOR=nvim
export GH_BROWSER=firefox
export GH_CONFIG_DIR=$HOME/.config/gh
export GIT_CONFIG_GLOBAL=$XDG_CONFIG_HOME/git/.gitconfig
export GIT_CONFIG=$XDG_CONFIG_HOME/git/.gitconfig
export GITHUB_USERNAME=robbpaulsen
export PATH=$PATH:/home/heimdal/Downloads/git-repos/hashcat-utils/src
export MDCAT_PAGER=bat
export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij
export ZELLIJ_CONFIG_FILE=$HOME/.config/zellij/config.kdl
export PATH=$PATH:$HOME/Downloads/git-repos/hash-cracker/scripts/extensions/hashcat-utils-linux/bin
export RUSTFLAGS="-C target-feature=-crt-static"
export PATH=$PATH:$HOME/Playgrounds/object-orientedp/flutter/bin
export PATH=$PATH:$HOME/Downloads/android-studio/bin
export PATH=$PATH:$HOME/Downloads/cmdline-tools/bin
export KITTY_CONFIG_DIRECTORY=$HOME/.config/kitty
export KITTY_CACHE_DIRECTORY=$HOME/.cache/kitty
export KITTY_OS=linux
export RANGER_DEVICONS_SEPARATOR=" "
export LS_COLORS=$(vivid -m 24-bit generate catppuccin-frappe)
export CHROME_EXECUTABLE=/usr/bin/google-chrome
export BAT_CONFIG_PATH=$HOME/.config/bat
export YTFZF_SYSTEM_ADDONS_DIR=/usr/local/share/ytfzf/addons

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

. ~/.config/zsh/.aliases.zsh
. ~/.config/zsh/.functions.zsh
. ~/.config/zsh/.key-bindings.zsh
. ~/.config/zsh/.typos.zsh
. $XDG_DATA_HOME/cargo/env

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.local/share"/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#source ~/.local/share/oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# AFX
#source <(~/go/bin/afx completion zsh)

# Enable afx plugins installed
#source <(~/go/bin/afx init)
