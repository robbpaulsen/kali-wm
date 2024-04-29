#!/usr/bin/env bash

#########################################################################################
## Author:   Robbpaulsen
## GitHub:   github.com/robbpaulsem
##
## set -x -e
#########################################################################################
## Author:	Robbpaulsen
## Website:	https://github.com/robbpaulsen
## Email:	ozymandias.1987@protonmail.com
#########################################################################################
## Descripcion:
##
## Segundo Script para instalar los lenguajes de programacion mas usados y librerias
## Rust, Go, Node, NPM (Administrador de Versiones de Node y Yarn), NVM (Administrador
## de Versiones solo para NPM), Cargo (Administrador de librerias y paquetes de Rust)
##
#########################################################################################
## tput setaf 0 = black
## tput setaf 1 = red
## tput setaf 2 = green
## tput setaf 3 = yellow
## tput setaf 4 = dark blue
## tput setaf 5 = purple
## tput setaf 6 = cyan
## tput setaf 7 = gray
## tput setaf 8 = light blue
########################################################################################

XDG_CACHE_HOME="$HOME"/.cache
XDG_CONFIG_HOME="$HOME"/.config
XDG_DATA_HOME="$HOME"/.local/share
XDG_DESKTOP_DIR="$HOME"/Desktop
XDG_DOCUMENTS_DIR="$HOME"/Documents
XDG_DOWNLOAD_DIR="$HOME"/Downloads
XDG_MUSIC_DIR="$HOME"/Music
XDG_PICTURES_DIR="$HOME"/Pictures
XDG_PUBLICSHARE_DIR="$HOME"/Public
XDG_STATE_HOME="$HOME"/.local/state
XDG_TEMPLATES_DIR="$HOME"/Templates
XDG_VIDEOS_DIR="$HOME"/Videos
CARGO_HOME="$HOME"/.cargo
CARGO_DEFAULT_BIN=$CARGO_HOME/bin
BIN_DIR="$BIN_DIR":-$CARGO_DEFAULT_BIN
GEM_HOME="$HOME"/.gem
GH_CONFIG_DIR="$HOME"/.config/gh
GIT_CONFIG="$XDG_CONFIG_HOME"/git/.gitconfig
GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME"/git/.gitconfig
GOPATH="$HOME"/go
GOROOT="$HOME"/.go
PATH="$GOPATH"/bin:"$GOROOT"/bin:"$HOME"/.local/bin:$PATH
GO111MODULE=on
JAVA_HOME=/lib/jvm/bellsoft-java17-full.x86_64
PIPX_BIN_DIR="$HOME"/.local/pipx/bin
PIPX_HOME_DIR="$HOME"/.local/pipx/venvs
RUSTFLAGS="-C target-feature=-crt-staticg"
RUSTUP_HOME=~/.rustup
YTFZF_SYSTEM_ADDONS_DIR=/usr/local/share/ytfzf/addons
_JAVA_OPTIONSa="-Djava.util.prefs.userRoot"="$XDG_CONFIG_HOME"/java

if [ "$(id -u)" == "0" ]; then
	tput setaf 3
	echo -e "\n[+] Este script se ejecuta sin SUDO ...\n"
	tput sgr 0
	exit
fi

ctrl_c() {
	tput setaf 3
	echo -e "\n\t[!] Saliendo del Script ...\n"
	tput sgr 0
	exit
}
trap ctrl_c INT

exit_script() {
	tput setaf 3
	echo -e "\n\t[!] Saliendo del Script ...\n"
	tput sgr 0
	exit
}

picom_installer() {
	cd $HOME/Downloads/
	git clone https://github.com/pijulius/picom.git
	cd picom/
	git submodule update --init --recursive
	meson --buildtype=release . build
	ninja -C build
	sudo ninja -C build install
	cd $HOME/Downloads/
	git clone https://github.com/VaughnValle/blue-sky.git
	cd blue-sky/polybar/
	cp -r ./* $HOME/.config/polybar/

}

plangs_installer() {
	cd $HOME/
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y &&
		rustup update
	source $HOME/.zshrc
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source $HOME/.zshrc
	nvm install --lts &&
		nvm use --lts &&
		npm install --global yarn
	wget https://git.io/go-installer.sh && bash go-installer.sh
}

configs_setup() {
	cp -r assets/kali-config/* $HOME/.config/
}

rbt_sys() {
	clear
	tput setaf 3
	echo -e "\n\t[!] El sistema se reiniicara en 5 segundos\n"
	sleep 6
	systemctl reboot
}

menu() {
	clear
	while true; do
		source assets/colors/debian
		tput setaf 6
		echo -e "\n$1 1 [+] Instalar Picom de Pijulius ..."
		echo -e "\n$2 2 [+] Instalar Lenguajes de Programacion ..."
		echo -e "\n$3 3 [+] Instalar Configuraciones ..."
		echo -e "\n$4 4 [+] Instalar Todo  ..."
		tput sgr 0
		echo ""
		tput setaf 3
		echo -e "\n$5 5 [+] Reiniciar Sistema ..."
		tput sgr 0
		echo ""
		tput setaf 1
		echo -e "\n$6 6 [!] Salir ..."
		tput sgr 0
		echo ""
		tput setaf 2
		read -p "Elige la opcion deseada: " numero
		tput sgr 0
		case $numero in

		1)
			clear
			picom_installer
			;;
		2)
			clear
			plangs_installer
			;;
		3)
			clear
			configs_setup
			;;
		4)
			clear
			configs_setup
			picom_installer
			plangs_installer
			;;
		5)
			rbt_sys
			;;
		6)
			exit_script
			;;
		*)
			tput setaf 1
			echo -e "\n\t[!] Opcion no Valida, Intenta de Nuevo ..."
			tput sgr 0
			;;
		esac
	done
}
menu
