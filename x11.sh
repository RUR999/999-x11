#!/bin/bash
r="\033[1;31m"
g="\033[1;32m"
c="\033[1;36m"
b="\033[1;34m"
n="\033[0m"
boxg="\033[1;34m[\033[1;32m+\033[1;34m]"
boxr="\033[1;34m[\033[1;31m!\033[1;34m]"
. <(curl -sLo- "https://raw.githubusercontent.com/RUR999/spinner/refs/heads/main/spin.sh")

banner() {
    echo -en "\n${b}╭━━━╮╭━━━╮╭━━━╮╱╱╱╱╱╭╮╱╱╭╮\n┃╭━╮┃┃╭━╮┃┃╭━╮┃╱╱╱╱╭╯┃╱╭╯┃\n┃╰━╯┃┃╰━╯┃┃╰━╯┃╭╮╭╮╰╮┃╱╰╮┃\n╰━━╮┃╰━━╮┃╰━━╮┃╰╋╋╯╱┃┃╱╱┃┃\n╭━━╯┃╭━━╯┃╭━━╯┃╭╋╋╮╭╯╰╮╭╯╰╮\n╰━━━╯╰━━━╯╰━━━╯╰╯╰╯╰━━╯╰━━╯\n                    by RUR 999\n\n${n}"
}


termux-setup-storage
clear;banner
(pkg update;pkg upgrade -y ) &> /dev/null & spin

pkgs=( x11-repo termux-x11-nightly xfce4 xfce4-goodies tur-repo xcompmgr xmlstarlet )
for pkg in "${pkgs[@]}";do
    echo -e "${boxg} ${g}Installing ${pkg}${n}"
    (pkg install -y ${pkg}) &> /dev/null & spin
done

if [[ $(command -v chromium) ]]; then
    echo -e "${boxg}${g} Chromium Browser Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing Chromium Browser ${n}"
    (pkg install -y chromium) &> /dev/null & spin
fi

if [[ $(command -v firefox) ]]; then
    echo -e "${boxg}${g} Firefox Browser Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing Firefox Browser ${n}"
    (pkg install -y firefox) &> /dev/null & spin
fi

if [[ $(command -v code-oss) ]]; then
    echo -e "${boxg}${g} VS Code Editor Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing VS Code Editor${n}"
    (pkg install -y code-oss) &> /dev/null & spin
fi

if [[ $(command -v parole) ]]; then
    echo -e "${boxg}${g} Parole Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing Parole Media Player${n}"
    (pkg install -y parole) &> /dev/null & spin
fi

if [[ $(command -v ristretto) ]]; then
    echo -e "${boxg}${g} Ristretto Image Viewer Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing Ristretto Image Viewer${n}"
    (pkg install -y ristretto) &> /dev/null & spin
fi

if [[ $(command -v inkscape) ]]; then
    echo -e "${boxg}${g} inkscape Image Editor Already Installed${n}"
    sleep 2
    else
    echo -e "${boxg}${g} Installing inkscape Image Editor${n}"
    (pkg install -y inkscape) &> /dev/null & spin
fi

rurfish(){
    echo -en "${boxq} ${g}Do You Want To Install Fish Functions? (y/n)${n} "
    read yn
    case $yn in
    Y|y)
    echo -e "${boxg} ${g}Installing Fish Functions${n}"
    (curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/999.sh -o 999.sh) &> /dev/null & spin
    bash 999.sh
    rm -rf 999.sh
    ;;
    N|n) 
    echo ""
    chsh -s fish
    ;;
    *) echo -e "${boxr} ${r}Wrong Input"
    rurfish
    ;;
    esac
}

rm -rf $PREFIX/bin/x11
rm -rf $PREFIX/bin/stopx11

cat >> $PREFIX/bin/x11 <<- _EOF_
#/data/data/com.termux/files/usr/bin/bash

# Kill open X11 processes
pkill -f com.termux.x11

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

# Run XFCE4 Desktop
env DISPLAY=:0 dbus-launch --exit-with-session xfce4-session & > /dev/null 2>&1

exit 0
_EOF_

cat >> $PREFIX/bin/stopx11 <<- _EOF_
pkill -f com.termux.x11
_EOF_

chmod +x $PREFIX/bin/x11
chmod +x $PREFIX/bin/stopx11
chsh -s fish
termux-reload-settings
sleep 3
clear;banner
echo -en "${boxg}${g} Just Type ${c}x11 ${g}For Run Termux-x11\n${boxg} ${g}Type ${c}stopx11 ${g}For Stop Termux-x11${n}\n\n\n"
