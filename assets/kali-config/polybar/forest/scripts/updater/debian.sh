#!/usr/bin/env bash

# COLORS THE SCRIPT
Black='\033[1;30m'
Red='\033[1;31m'
Green='\033[1;32m'
Yellow='\033[1;33m'
Blue='\033[1;34m'
Purple='\033[1;35m'
Cyan='\033[1;36m'
White='\033[1;37m'
NC='\033[0m'
blue='\033[0;34m'
white='\033[0;37m'
lred='\033[0;31m'

# PRESENT THE SCRIPT
banner() {
	echo ""
	echo -e "${Blue} ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗${NC}"
	echo -e "${Blue} ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝${NC}"
	echo -e "${Blue} ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗${NC}"
	echo -e "${Blue} ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝${NC}"
	echo -e "${Blue} ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗${NC}"
	echo -e "${Blue}  ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝${NC}"
}

# PRINT BANNER AND UPDATE KALI
update() {
	banner
	echo ""
	echo -e "${Blue} [${Yellow}⇅${Blue}]${White} Checking if aptitude is Installed${NC}"
	if which aptitude >/dev/null; then
		sleep 1
		echo ""
		echo -e "${Blue} [${Cyan}i${Blue}]${White} Aptitude is installed on your system ...${NC}"
		echo -e "${Blue} [${Cyan}i${Blue}]${White} What do you want to do after the update?${NC}"
		echo ""
		echo -e "${Blue} [${Cyan}1${Blue}] Nothing${NC}"
		echo -e "${Blue} [${Cyan}2${Blue}] Restart${NC}"
		echo -e "${Blue} [${Cyan}3${Blue}] Shutdown${NC}"
		echo ""
		echo -ne "${White} > ${NC}"
		read Quest
		case $Quest in
		1)
			echo ""
			echo -e "${Blue}[${Yellow}⇅${Blue}]${White} Updating system${NC}"
			sudo aptitude update >/dev/null
			sudo apt list --upgradable
			sleep 3
			sudo aptitude --verbose --safe-resolver --assume-yes full-upgrade
			exit 0
			;;
		2)
			echo ""
			echo -e "${Blue}[${Yellow}⇅${Blue}]${White} Updating system and reboot${NC}"
			sudo aptitude --assume-yes --verbose update 2>/dev/null
			sudo aptitude --verbose --assume-yes --safe-resolver full-upgrade
			sleep 3
			systemctl reboot
			exit 0
			;;
		3)
			echo ""
			echo -e "${Blue}[${Yellow}⇅${Blue}]${White} Updating system and shutting down${NC}"
			sudo aptitude --assume-yes update >/dev/null
			sudo apt list --upgradable
			sleep 3
			sudo aptitude --assuem-yes --verbose --safe-resolver ful-upgrade && systemctl poweroff
			exit 0
			;;
		*)
			echo ""
			echo -e "${Blue}[${Yellow}⇅${Blue}]${White} Invalid option, use the capital letters 1/2/3  launch the script again!${NC}"
			sleep 2
			exit 1
			;;
		esac
	else
		echo ""
		sleep 1
		echo -e "${Blue}[${Cyan}i${Blue}]${White} Installing Aptitude from apt backend${NC}"
		sudo apt-get --assume-yes --verbose install aptitude
		echo ""
		echo -e "${Blue} [${Cyan}i${Blue}]${White} Aptitude is already installed, launch the script again!${NC}"
		sleep 1
		exit 0
	fi
}

# CALL UPDATE AND RESET
reset
update
