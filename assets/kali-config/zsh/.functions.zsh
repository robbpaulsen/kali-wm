# Create a directory and cd into it
cdd() {
	cd "$(lsd -d -- */ | fzf)" || echo "Invalid directory"
}

# Get the list of recet directories visited with `cd` command
 recent_dirs() {
	# This script depends on pushd. It works better with autopush enabled in ZSH
	escaped_home=$(echo $HOME | sed 's/\//\\\//g')
	selected=$(dirs -p | sort -u | fzf)

	cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

# Create Directories to start a pentesting session
 mkt() {
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
 extractPorts() {
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" >extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address" >>extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n" >>extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n" >>extractPorts.tmp
	cat extractPorts.tmp
	rm extractPorts.tmp
}

# Set 'man' colors
man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
fzf-lovely() 
{

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:30 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (~/.cargo/bin/bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  /bin/cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (~/.cargo/bin/bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          /bin/cat {}) 2> /dev/null | head -500'
	fi
}

# Free cache and perform quick scrubbing
rmk() {
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Get a random shell tip
rndmtip() {
  curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md | 
    sed '/cowsay[.]png/d' | 
    pandoc -f markdown -t html |
    xmlstarlet fo --html --dropdtd |
    xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
    xmlstarlet unesc | fmt -80 | iconv -t US
}

# Extract the actual terminal size
get_term_size() {
    # Usage: get_term_size

    # (:;:) is a micro sleep to ensure the variables are
    # exported immediately.
    shopt -s checkwinsize; (:;:)
    printf '%s\n' "$LINES $COLUMNS"
}

# extract the exact size of the focused window
get_window_size() {
    # Usage: get_window_size
    printf '%b' "${TMUX:+\\ePtmux;\\e}\\e[14t${TMUX:+\\e\\\\}"
    IFS=';t' read -d t -t 0.05 -sra term_size
    printf '%s\n' "${term_size[1]}x${term_size[2]}"
}

# find the most common/repeated word on a file
mode() {
  if [[ $# -ne 1 ]]; then
    echo 'find the most common item in file'
    echo 'EXAMPLE: mode <FILE>'
  else
    LC_ALL=C sort -T ./ $1 | uniq -c | LC_ALL=C sort -T ./ -rn
  fi
}

# unique sort file
usort() {
  if [[ $# -ne 1 ]]; then
    echo 'unique sort file inplace'
    echo 'EXAMPLE: usort <FILE>'
  else
    LC_ALL=C sort -u $1 -T ./ -o $1
  fi
}

get_display() {
  dispmngr="$(grep 'ExecStart' /etc/systemd/system/display-manager.service | tr '/' ' ' | awk '{ print $NF }')"
  echo -e "\n[+] This is your display manager: $dispmngr\n"
}

ctrl_l() {
    builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"$TTY"
    builtin zle .reset-prompt
    builtin zle -R
}
zle -N ctrl_l
bindkey '^l' ctrl_l

# retrieve SELinux enforcing status
genf() {
  getenforce
}

# set SELinux enforce status to Permissive
set_free() {
  sudo setenforce 0 &&
      enfstat="$(getenforce)"
      echo $enfstat
}

# check your weather putting city as parameter
weather() {
  curl "https://v2.wttr.in/$1"
}

# cheat-sheet in terminal
cheatsheet() {
  curl "https://cht.sh/$1"
}

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo ''$1' cannot be extracted via ex()' ;;
    esac
  else
    echo ''$1' is not a valid file'
  fi
}

kln_lns() {
  awk '{ if (!seen[$0]++) print }' $1
}

test_colors1() {
  curl -s https://gist.githubusercontent.com/WoLpH/8b6f697ecc06318004728b8c0127d9b3/raw/colortest.py | 
    python
}

test_colors2() {
  for code ({000..255}) print -P -- "\n\n$code: %F{$code}This is how your text would look like%f\n"
}

# System is laggy, you migh thave zombie processes to kill
any_zombies() {
     ps -xaw -o state -o ppid |
          grep Z |
          grep -v PID |
          awk '{print $2}'
}

# Kill all the laggy  zombie processes found
 kill_emall() {
     kill -9 `ps -xaw -o state -o ppid |
          grep Z |
          grep -v PID | 
          awk '{print $2}'`
}

test_colors3() {
  awk 'BEGIN{
  s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
  for (colnum = 0; colnum<77; colnum++) {
    r = 255-(colnum*255/76);
    g = (colnum*510/76);
    b = (colnum*255/76);
    if (g>255) g = 510-g;
      printf "\033[48;2;%d;%d;%dm", r,g,b;
      printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
      printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
  }'
}

knowledge() {
  tldr --list |
    fzf --layout=reverse --preview 'tldr {1} --color=always' --preview-window=right,70% |
    xargs tldr
}

# Color Testing for zsh
typeset -AHg FX FG BG
FX=(
  reset     "%{%}"
  bold      "%{%}" no-bold      "%{%}"
  dim       "%{%}" no-dim       "%{%}"
  italic    "%{%}" no-italic    "%{%}"
  underline "%{%}" no-underline "%{%}"
  blink     "%{%}" no-blink     "%{%}"
  reverse   "%{%}" no-reverse   "%{%}"
)
for color in {000..255}; do
  FG[$color]="%{color}m%}"
  BG[$color]="%{color}m%}"
done

# Show all 256 colors with color number
spectrum_ls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${FG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}

# Show all 256 colors where the background is set to specific color
spectrum_bls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${BG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}

# Rename Lazy Vims Config Dir for the VIM fundamentals Course
rnme_lazy() {
  nname=$HOME/.config/nvim-TEMP
  oname=$HOME/.config/nvim
  cname=$HOME/.config/nvim-FUNDAMENTALS

  mv $oname $nname &&
    mv $cname $oname
}

rnme_backlazy() {
  nname=$HOME/.config/nvim-TEMP
  oname=$HOME/.config/nvim
  cname=$HOME/.config/nvim-FUNDAMENTALS

  mv $oname $cname &&
    mv $nname $oname
}

# Do you trust all the website's you visit?, pull all the Certificates that are stored on othe system
show_certs() {
  awk -v cmd='openssl x509 -noout -subject' '/BEGIN/{close(cmd)};{ print | cmd }' < /etc/ssl/certs/ca-certificates.crt
}

# Get the cabinet Average Fan Spedd
fan_speed(){
  speed="$(sensors | grep fan2 | awk '{print $2; exit}')"

  if [ "$speed" != "" ]; then
    speed_round=$(echo "$speed/1000" | bc -l | LANG=C xargs printf "%.1f\n")
    echo "# $speed_round"
  else
    echo "#"
  fi
}

wless_down(){
  alias ip='sudo /usr/sbin/ip'
  wiface=$(iw dev | grep "Interface " | xargs | cut -d " " -f 2)

  ip link set $wiface down
}

wless_rmac(){
  alias macchanger='sudo /bin/macchanger'
  wiface=$(iw dev | grep "Interface " | xargs | cut -d " " -f 2)

  sudo macchanger -a $wiface
}

wless_omac(){
  alias macchanger='sudo /bin/macchanger'
  wiface=$(iw dev | grep "Interface " | xargs | cut -d " " -f 2)

  sudo macchanger -p $wiface
}

wless_mon(){
  alias iw='sudo /usr/sbin/iw'
  wiface=$(iw dev | grep "Interface " | xargs | cut -d " " -f 2)

  iw dev $wiface set type monitor
}

wless_up(){
  alias ip='sudo /usr/sbin/ip'
  wiface=$(iw dev | grep "Interface " | xargs | cut -d " " -f 2)

  ip link set $wiface up
}

# Unblock any NIC inside RFKILL's prision
wless_unblock(){
  sudo rfkill unblock all
}

# Inplace file/files Archiver/backup, and will name it with the date
tar_pressed() {
  DATE=($(date +%s%d%m%Y))
  tar -zcf backup-${DATE} -C $1 $2 # orden de los archivos "-zcf backup-etc es el nombre del comprimmido que se creara , -C es el directorio base de donde sincronizara y el siguiente argumto es el directorio destino"
}

# Extract Emails from a big chunky File
eml_extractor() {
  grep -HiEhr -o -e "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*" |
    grep '\S'
}

# Decode ROT 13 strings
rot13 () {
	if [ $# -eq 0 ]; then
		tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	else
		echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	fi
}

# Get the Distribution installed on System
get_distro()
{
  cat /etc/os-release | tr '"' " " | grep -E "NAME" | head -n 1 | awk -F " " '{ print $2 }'
}

# Pull CPU Brand/Model Information
get_cpu()
{
  awk -F '\\s*: | @' '/model name|Hardware|Processor|^cpu model|chip type|^cpu type/ { cpu=$2; if ($1 == "Hardware") exit } END { print cpu }' /proc/cpuinfo
}

# Trim leading and trailing spaces (for scripts)
trim() {
	local var=$@
	var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace characters
	echo -n "$var"
}

# Pull the GPU Information and Model
get_gpu() {
  lspci -mm | awk -F '\"|\" \"|\\(' '/"Display|"3D|"VGA/ {a[$0] = $1 " " $3 " " $4} END {for(i in a) {if(!seen[a[i]]++) print a[i]}}' | awk -F " " '{ print $2,$3,$4,$5,$6,$7 }' | sed 's/\[//g' | sed 's/\]//g'
}


# Downlaod an entire YT Playlist which will create a directory containing the name of playlist and all videos on chronological order
yt_playlist ()
{
   yt-dlp -o "%(playlist)s/%(playlist_index)s" -f "bv+ba/b" "$1"
}

# Render markdown file with Glow
glowit()
{
  < "$1" | glow
}

# Render markdown file with Inlyne a browserless and independent Markdown renderer
show_it()
{
  inlyne "$1"
}

# Search DNF installed app DB for a app/pkg
app_search()
{
  dnf list --installed | grep -iE "$1"
}

# Take control of your services and start your online presence manually
net_up()
{
  sudo systemctl start NetworkManager.service
}


# Take control of your services and start your wifi online presence manually
wlannet_up()
{
  sudo systemctl start wpa_supplicant.service NetworkManager.service
}


# Take control of your services and stop your wifi presence manually
wlannet_down()
{
  sudo systemctl stop wpa_supplicant.service NetworkManager.service
}

# Convert HTML file to Markdown
html2mdown()
{
  pandoc -f html -t markdown  -i "$1" -o "$2".md
}

# Convert Markdown file to HTML
mdown2html()
{
  pandoc -f markdown -t html -i "$1" -o "$2".html
}

# Convert Markdown file to PDF
mdown2pdf()
{
    pandoc -f markdown -t pdf -i "$1" -o "$2".pdf
}

settarget(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > $HOME/.config/bspwm/scripts/target
}

cleartarget(){
    echo '' > $HOME/.config/bspwm/scripts/target
}

 commands() {
  echo "\033[0;91m ============== ALL COMMANDS AVAILABLE =============="
  echo "weather         [city]      - Check weather"
  echo "cheatsheet      [command]   - cheatsheet online"
  echo "cdd                         - Cd into dir with fzf"
  echo "recent_dirs                 - View most recent accesed dirs"
  echo "mkt                         - Create a tree layout for pentest workflow"
  echo "extractPorts    [file]      - Extract the discovered ports from an Nmap file"
  echo "fzf-lovely                  - Dynamic pre-viewer with Fzf and bat"
  echo "rndmtip                     - Recieve a random tip from Cowsays"
  echo "get_term_size               - Get the terminal size in columns"
  echo "get_window_size [command]   - Get the window size in columns"
  echo "test_colors1                 - Test colors #1"
  echo "test_colors2                 - Test colors #2"
  echo "test_colors3                 - Test colors #3"
  echo "mode            [file]      - Find the most common/repeated word on a file"
  echo "usort           [file]      - in place sort the order of a file with many lines"
  echo "get_display                 - Get the name of the Display Manager"
  echo "ex              [file]      - EXtractor for all kind of archives"
  echo "kln_lns         [file]      - Print unsorted unique lines from a list/text file"
  echo "knowledge                   - Explore the TLDR pages and search for a command"
  echo "kill_emall                  - Kill any zombie process taking forever"
  echo "any_zombies                 - find zombie processes"
  echo "trim            [file]      - Trim leading and trailing spaces (for scripts)"
  echo "get_gpu                     - Pull the GPU Information and Model"
  echo "yt_playlist     [YT-URL]    - Downlaod an entire YT Playlist which will create a directory containing the name of playlist and all videos on chronological order"
  echo "glow_it         [file]      - Render markdown file with Glow"
  echo "show_it         [file]      - Render markdown file with Inlyne a browserless and independent Markdown renderer"
  echo "app_search      [file]      - Search DNF installed app DB for a app/pkg"
  echo "net_up                      - Take control of your services and start your online presence manually"
  echo "wlannet_up                  - Take control of your services and start your wifi online presence manually"
  echo "wlannet_down                               - Take control of your services and stop your wifi presence manually"
  echo "html2mdown [html file] [Md file.md]        - Convert HTML file to Markdown"
  echo "mdown2html  [Md file] [HTML new file.html] - Convert Markdown file to HTML" 
  echo "mdown2pdf  [Md file] [PDF file.pdf]        - Convert Markdown file to PDF"
# echo ""
# echo ""
# echo ""
# echo ""
  echo "\033[0;91m ===================================================="
}