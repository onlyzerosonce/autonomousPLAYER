#!/bin/bash
#earphoneline=134
#Log file is $0.log
# set -euo pipefail
# IFS=$'\n\t' 

echo iamalive
THRESHOLDSPACE=40000000 # 30 Gb
#sudo crontab -l>.crontabbackup
issaturday() { date|awk '{print $1}'|grep -iv 'sat';};

#FULLAUTONAUMUS="" # set FULLAUTONAUMUS = 1 for FULLAUTONAUMUS functionality


transmission-gtk -m&
sleep 3
TorrentCount=$(transmission-remote -l|awk '{print $1}'|grep -oE '[0-9]*'|tail -1 | wc -l)

killeverythingAndexit() {
	echo "Exiting formally"
		echo "killing mplayer"
		pkill -f m.sh
		echo "killing download"
		pidof transmission-gtk&&killall transmission-gtk 
		echo "killing music"
		kill "$(xprop -name bash|grep -iEo 'PID.*'|grep -iEo '[0-9]*')"
		echo "exiting now . bye bye "
		exit ;
}

feh --bg-scale CompleteBlackWallpaper.png
changewallpaper() {
	echo $(( $(grep -e '[0-9]' "$HOME"/.wallprunning) % $(ls "$HOME"/wallp/*jpg| wc -l) +1 ))>"$HOME"/.wallprunning;
	i=$(grep -e '[0-9]' "$HOME"/.wallprunning)
	i=$(ls "$HOME"/wallp/*jpg|head -"$i"|tail -1)
	feh --bg-scale "$i"
#gsettings set org.gnome.desktop.background picture-uri file://$i;
} 

( pidof transmission-gtk||transmission-gtk -m& ) && transmission-remote -t all -S

##tempstartoldest
function startoldest(){
	maxid=$(transmission-remote -l|awk '{print $1}'|grep -oE '[0-9]*'|tail -1)
	for id in $(seq 1 1 "$maxid")
do
	d="$(transmission-remote -t "$id" -i|grep -io 'date added.*'|awk '{print $4" "$5" "$6" "$7}')"
	echo "$(date -d "$d" +%Y%m%d%M%S)" "$id" >>.transmissionremotetemp
done
high=$(sort .transmissionremotetemp|head -2|awk '{print $2}'|head -1)
low=$(sort .transmissionremotetemp|head -2|awk '{print $2}'|tail -1)

transmission-remote -t "$high" -s
transmission-remote -t "$low" -s

transmission-remote -l |awk '{print $2" "$1}'|grep -iE '([0-9]*%|n/a)' |sort -h|grep '100%'&&transmission-remote -t "$(transmission-remote -l |awk '{print $2" "$1}'|grep -iE '([0-9]*%|n/a)' |sort -h|grep '100%'|awk '{print $2}'|head -1)" -r ;
rm .transmissionremotetemp;
}

torrentaction(){
#TorrentCount=0
pidof transmission-gtk && TorrentCount=$(transmission-remote -l|awk '{print $1}'|grep -Eo '[0-9]*'|tail -1 | wc -l)
if [[ "$TorrentCount" == 0 ]]
then
killall transmission-gtk
else 
	eval [ "$(df /2 | tail -1 | awk -v i=$THRESHOLDSPACE '{print $4" -gt "i }')" ] && ( pidof transmission-gtk||transmission-gtk -m& ) &&startoldest
	eval [ "$(df /2 | tail -1 | awk -v i=$THRESHOLDSPACE '{print $4" -lt "i }')" ] && pidof transmission-gtk&&killall transmission-gtk 
fi
}

function autobackup () {
	fbk=$(find "$0" -maxdepth 0 -printf "%f_%TY%Tm%Td%TH%TM")
[ ! -f "$fbk" ] && cp "$0" "$fbk" && echo "#bakupfilename=$fbk">>"$fbk"
}
autobackup

##### every 10 minutes
while : ; do
###################################### <exiting formalities> #####################################
[ ! -f .autonaumasplayerinput ] && killeverythingAndexit 
###################################### </exiting formalities> #####################################
torrentaction ;
# changewallpaper &&
timeout 5 zenity --notification --text="$(head -"$(echo "$RANDOM%$(wc -l todo|awk '{print $1}')"+1|bc)" todo|tail -1)" --title=" Message from Logical mind " ;
sleep 600s
done & 

########################################### consume media ########################################
#while : ; do 
#exec terminator -p Transparent --geometry 800x600+5+25 -x /bin/bash "$HOME"/m.sh &
#wait $!
#sleep 1s 
###################################### <exiting formalities> #####################################
#[ ! -f .autonaumasplayerinput ] && killeverythingAndexit 
###################################### </exiting formalities> #####################################
#done &

## moved to another script 
#      	while : ; do
#      ###################################### <exiting formalities> #####################################
#      	[ ! -f .autonaumasplayerinput ] && killeverythingAndexit 
#      ###################################### </exiting formalities> #####################################
#      
#      # [ "`pacmd list-sink-inputs|egrep -i -o '(running|drained)'|wc -l`" -eq "0" ]  &&   { pidof evince||pgrep -fl delmu.sh|| xterm -e /bin/bash $HOME/delmu.sh& }
#      [ "$(pacmd list-sink-inputs|grep -iEo '(running|drained)'|wc -l)" -eq "0" ]  &&   { 
#      
#      #vol=$(amixer sget 'Master' -c 1|tail -1|egrep -io "[[][0-9]*%[]]"|egrep -io '[0-9]*')
#      #amixer sset 'Master' "75"% -c 1
#      pgrep -fl delmu.sh|| xterm -e /bin/bash "$HOME"/delmu.sh& 
#      }
#      if [ $((0$(pacmd list-sink-inputs|grep -iEo '(bell event|running)'|awk '{ for(i=1; i<=NF; i++) if(tolower($i)=="running") c++ ;else if(tolower($i)=="bell") c-- } END{ print c }'))) -gt "1" ] ; then
#      # if [ $((0`pacmd list-sink-inputs|egrep -io '(bell event|running)'|awk '{ for(i=1; i<=NF; i++) if(tolower($i)=="running") c++ ;else if(tolower($i)=="bell") c-- } END{ print c }'`)) -gt "1" ] || [ `pidof evince` ] ; then
#      
#      
#      pkill -f delmu.sh # xprop -name bash|egrep -io 'PID.*'|egrep -io '[0-9]*'&& kill `xprop -name bash|egrep -io 'PID.*'|egrep -io '[0-9]*'`
#      #amixer sset 'Master' "$vol"% -c 1
#      fi
#      
#      
#      #desktop=`wmctrl -d| grep '*'|awk '{print $1}'`
#      #case $desktop in 
#      #[^02]) 
#      #pgrep -fl delmu.sh|| xterm -e /bin/bash $HOME/delmu.sh& sleep 5s; 
#      #[ -f shutdown.sha ] && mv shutdown.sha shutdown.sh
#      #;;
#      #*) pkill -f delmu.sh;
#      #[ -f shutdown.sh ] && mv shutdown.sh shutdown.sha
#      #;;
#      #esac	
#      
#      	sleep 3
#      	done # 2>&1 |more>$0.log
#      #bakupfilename=autonaumusPLAYER.sh_201602211146
