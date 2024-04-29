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
## Primer Script para preparar un sistema y configurarlo para
## Uso de Tiling Window Manager BSPWM
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

if [ "$EUID" -ne 0 ]; then
	tput setaf 3
	echo -e "\n[+]Se te olvido el sudo ...\n"
	tput sgr 0
	exit
fi

function ctrl_c() {
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

update_vm() {
	clear
	tput setaf 8
	echo -e "\n\t[+] Primer Script, despues de reiniciar se aplicara el segundo script\n"
	tput sgr 0
	echo ""
	apt-get --assume-yes update &&
		apt-get --assume-yes full-upgrade &&
		sleep 3 &&
		apt-get --assume-yes install aptitude spice-svdagent needrestart &&
		sleep 3 &&
		spice-vdagent &&
		update-grub2
}

update_baremetal() {
	clear
	tput setaf 8
	echo -e "\n\t[+] Primer Update, despues de reiniciar se aplicara el segundo script\n"
	tput sgr 0
	apt-get --assume-yes update &&
		apt-get --assume-yes full-upgrade &&
		sleep 3 &&
		apt-get --assume-yes install aptitude needrestart &&
		sleep 3 &&
		spice-vdagent &&
		update-grub2
}

libsPkgs_installer() {
	clear
	tput setaf 3
	echo -e "\n\t[+] Instalacion librerias y paquetes necesarios ...\n"
	tput sgr 0
	echo ""
	while read -r line; do
		echo -e "${CYAN}\n[+]${NORMAL} ${GREEN}Instalando $line\n${NORMAL}"
		sudo aptitude --assume-yes --verbose --safe-resolver --with-recommends install "$line" &>/dev/null
	done <assets/libsPkgs.lst
	sleep 2
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
		echo ""
		echo -e "${WHITE} ╔───────────────────────────────────────────────╗"
		echo -e "${WHITE} |${CYAN} ██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗${WHITE} |"
		echo -e "${WHITE} |${CYAN} ██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║${WHITE} |"
		echo -e "${WHITE} |${CYAN} ██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║${WHITE} |"
		echo -e "${WHITE} |${CYAN} ██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║${WHITE} |"
		echo -e "${WHITE} |${CYAN} ██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║${WHITE} |"
		echo -e "${WHITE} |${CYAN} ╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝${WHITE} |"
		echo -e "${WHITE} ┖───────────────────────────────────────────────┙"
		tput setaf 6
		echo -e "\n$1 1 [+] Actualizar Maquina Virtual ...\n"
		echo -e "\n$2 2 [+] Actualizar Maquina Fisica ...\n"
		echo -e "\n$3 3 [+] Instalar Librerias y Aplicaciones para Window Manager ...\n"
		echo -e "\n$4 4 [+] Todo En Uno (NO RECOMNEDADO) Para VM ...\n"
		echo -e "\n$5 5 [+] Todo En Uno (NO RECOMNEDADO) Para Maquina fisica ...\n"
		tput sgr 0
		echo ""
		tput setaf 3
		echo -e "\n$6 6 [+] Reiniciar Sistema ...\n"
		tput sgr 0
		echo ""
		tput setaf 1
		echo -e "\n$7 7 [!] Salir ...\n"
		tput sgr 0
		echo ""
		tput setaf 2
		read -p "Elige la opcion deseada: " numero
		tput sgr 0
		case $numero in

		1)
			update_vm
			;;
		2)
			update_baremetal
			;;
		3)
			libsPkgs_installer
			;;
		4)
			update_vm
			libsPkgs_installer
			;;
		5)
			update_baremetal
			libsPkgs_installer
			;;
		6)
			rbt_sys
			;;
		7)
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
