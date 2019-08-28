#!/bin/bash
#for gnome use gnome-session-properties at terminal
#./andkey.sh&
# . $HOME/.functionslibrary/.functionlibrary
# . $HOME/.bashrc
# . $HOME/.bash_aliases
# #startplayer

# timeout 60 zenity --info --text="Please wait while this message doenst vanish" --title="Starting up services" &
# sleep 60s

#xrandr --auto && xrandr --output VGA-1-2 --off

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
nohup /bin/bash autonaumusPLAYER.sh >/dev/null 2>&1 &
#echo "Starting wallpaper downloader"
#exec bash $HOME/wallp/dl.sh >/dev/null 2>&1 &
#echo "Starting NOTD"
#nohup /bin/bash $HOME/NOTD.sh >/dev/null 2>&1 &

#echo "Starting ICEDOVE"
#nohup /usr/bin/icedove>/dev/null 2>&1 &

## echo "Starting VIBER"
## nohup /opt/viber/Viber >/dev/null 2>&1 &

#echo "Starting ARTHA"
#nohup artha >/dev/null 2>&1 &

#echo "Starting Songs Download"
#nohup /bin/bash $HOME/songs/DownloadSongs.sh >/dev/null 2>&1 &

#echo "Starting choqok"
#nohup choqok >/dev/null 2>&1 &

#echo "Starting clipit"
#nohup clipit >/dev/null 2>&1 &

#echo "Starting countdown"
#nohup /bin/bash $HOME/countdown.sh >/dev/null 2>&1 &

echo "Starting Id"
nohup /bin/bash "$HOME"/idmaster.sh >/dev/null 2>&1 &

#echo "Starting Youtube"
#nohup /bin/bash $HOME/Youtube/youtube.sh >/dev/null 2>&1 &

echo "Starting Conky"
nohup conky -c .conkyconfig > /dev/null 2>&1 &


echo "Starting automator"
#nohup (exec terminator -p Transparent --geometry i800x600+5+25 -x /bin/bash "$HOME"/automator.sh >/dev/null 2>&1 &

wmctrl -s 3

terminator -p Transparent --geometry i800x600+5+25 -x /bin/bash "$HOME"/automator.sh >/dev/null 2>&1 &


echo "starting kde indicator"
nohup indicator-kdeconnect  > /dev/null 2>&1 &




# echo "Starting Telegram"
# ./Telegram/Telegram &

#starting autobrowse.sh

#echo "Starting autobrowse"
#nohup bash autobrowse.sh >/dev/null 2>&1 &

#nohup transmission-gtk -m > /dev/null 2>&1 &
# bash start_transmission.sh

#sleep 5s;a=`transmission-remote -l |awk '{print $2" "$1}'|egrep -i '([0-9]*%|n/a)'|wc -l`
#[ "$a" -lt 2 ] &&  flexget execute ;


#addmovietime(){ a=`echo 0$(more .maxmovietime)+$1|bc`;echo $a > .maxmovietime; }
#addmovietime "-5400" 

#exec bash $HOME/sha/bulk/bulk.sh &

# rm $HOME/.maxmovietime
#dl.sh&
#indicator-sysmonitor.sh
#install.sh
#startup.sh
sleep 10
# kill -9 "$(ps --pid $$ -oppid=)"; exit # to kill the parent after running everything 

#exit 

fi
fi
