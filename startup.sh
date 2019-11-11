#!/bin/bash
#for gnome use gnome-session-properties at terminal

if [ ! -f /tmp/.auto-n-lock ] 
then 

# curlftpfs V:v@192.168.0.100/V/Data/3/ /3
#sleep .1s&&wmctrl -t 4 -r "bash"

echo "Locking for firstrun"
touch /tmp/.auto-n-lock 
sleep 5s

if wmctrl -m | grep -e "Name:"|grep -iq "awesome"
        then

#echo "Starting telegram"
#wmctrl -s 4 # default for the telegram.
#nohup telegram-sergiusens.telegram > /dev/null 2>&1 &

sleep 5s 

echo "Starting auto"

wmctrl -s 2 # default viewport

touch "$HOME"/.autonaumasplayerinput  # dont put exec with this it is causing the script to exit 
nohup /bin/bash autonaumusPLAYER/autonaumusPLAYER.sh >/dev/null 2>&1 &
#echo "Starting wallpaper downloader"
#exec bash $HOME/wallp/dl.sh >/dev/null 2>&1 &

#echo "Starting ARTHA"
#nohup artha >/dev/null 2>&1 &

#echo "Starting countdown"
#nohup /bin/bash $HOME/countdown.sh >/dev/null 2>&1 &

echo "Starting Id"
nohup /bin/bash "$HOME"/autonaumusPLAYER/idmaster.sh >/dev/null 2>&1 &

#echo "Starting Youtube"
#nohup /bin/bash $HOME/Youtube/youtube.sh >/dev/null 2>&1 &

echo "Starting Conky"
nohup conky -c "$HOME"/autonaumusPLAYER/.conkyconfig > /dev/null 2>&1 &

wmctrl -s 3

terminator -p Transparent --geometry i800x600+5+25 -x /bin/bash "$HOME"/automator.sh >/dev/null 2>&1 &

sleep 10

fi
fi
