#!/bin/bash
#xmodmap -pk
# set -euo pipefail
# IFS=$'\n\t' 
########## variables
a="$1"
[ "$a" == "" ]  && a="ParameterNotPassed"
firstrun=0
##########


function currentthings () {
clear
echo "#################### Current Things ################################"
[ -s .mplayer_delete ] && cat .mplayer_delete|head -2
[ -s .delete ] && cat .delete|head -2
#bash learningbashmanual.sh 
echo "#################### Current Things ################################"
}

appendattop () { echo "$2" | cat - "$1" > "/tmp/appendattop.$$" && mv "/tmp/appendattop.$$" "$1" ; }



function autobackup () { fbk=`find "$0" -maxdepth 0 -printf "%f_%TY%Tm%Td%TH%TM"` && [ ! -f "$fbk" ] && cp "$0" "$fbk" && echo "#bakupfilename=$fbk">>"$fbk"; }
autobackup

# currentthings

displaycurrentlist()		{ 	cat .mplayer_delete_parent|tac>/tmp/.displaycurrentlist$$
						cat .mplayer_delete_display|tac|awk '{print "     "$0}'|tail -40>>/tmp/.displaycurrentlist$$
						#cat .mplayer_delete_parent|wc -l >>/tmp/.displaycurrentlist$$
						echo `cat .mplayer_delete_parent|wc -l`/`find /2/Downloads/ -maxdepth 1|egrep -v '/$'|wc -l`>>/tmp/.displaycurrentlist$$
						timeout 5 zenity --notification --text="`cat /tmp/.displaycurrentlist$$|tail -50`" 2>/dev/null &
						# tail -50 /tmp/.displaycurrentlist$$
						}

pausemusic(){
# write code for pausemusic using xdotool and sendkeys to 
echo yet to implement the pause function
}

SearchAndPlay () {
# this will add the item to the playlist .mplayer_delete_parent
DirName=`zenity --file-selection --directory 2>/dev/null`; 
appendattop ".mplayer_delete_parent" "$DirName"
appendattop ".mplayer_delete_parent" ""
}

xinput test 12| while :;
do 
read line ; 
[[ $Key != "" ]] && PrevKey=$Key
Key=`echo $line|grep release|egrep -o '[0-9]*'`
#echo "Key:D"$Key"D&PrevKey:D"$PrevKey"D"

# [[ $SECONDS -gt 2 ]] && case "$Key" in 

#if [[ $PrevKey == 133 ]] 
# then 
case "$Key" in 

# b)	terminator & ;;
52)	terminator & ;; # mapped to z

d) 	read link; [ ! -z "$link" ] && wget "$link" && notify-send -u critical "Download complete" -i /3/pics/notify.jpeg;;
D) 	bash $HOME/.ShowCurrentWallp;;
e) 	(scite &) ;;
# f) 	(firefox &) ;;
41) 	(firefox &) ;;
g) 	(firefox gmail.com&);;
G)	(firefox -search "`xclip -o`" &);;
H)	(echo -100000 > .maxmovietime) ;;
k)	rm -f .autonaumasplayerinput;;
l)	localc;;
L) 	cat $0|grep -io '.*).*';;
m) 	(exec terminator -x /bin/bash $HOME/m.sh &)  ;;
n) 	(firefox naukri.com&) ;;
#o) 	delvariableindel=$(zenity --title="Select a file to 0pen" --file-selection --filename="`cat .historyofopenedfiles|tail -1`");[ -n "$delvariableindel" ] && echo $delvariableindel>>.historyofopenedfiles;[ -n "$delvariableindel" ] && gnome-open "$delvariableindel" ;;
32) 	delvariableindel=$(zenity --title="Select a file to 0pen" --file-selection --filename="`cat .historyofopenedfiles|tail -1`");[ -n "$delvariableindel" ] && echo $delvariableindel>>.historyofopenedfiles;[ -n "$delvariableindel" ] && gnome-open "$delvariableindel" ;;

O)	scite $0;;
p)	read -p "Add your priority task:" p && { [ "$p" ] && echo $p>>todo;[ ! "$p" ] && scite todo ;};;
P)	
	firefox "http://www.pornhub.com";;
r)	mv -v /2/Downloads/.DeletedItems/file.Content "`cat /2/Downloads/.DeletedItems/file.Name`";;		
s)	read -p "What do you want to search?" a && firefox -search "$a" ;;
#touch .autonaumasplayerinput && bash autonaumusPLAYER.sh& ;;
S)	sudo shutdown -h now ;;
#t)	thunar /2/Downloads/& ;;
28)	thunar /2/Downloads/& ;;
T) 	transmission-remote-cli;;
u)	echo "Going to update and upgrade";sudo apt-get update && sudo apt-get upgrade && sudo pip install --upgrade flexget;;
v) 	(exec terminator -x alsamixer &) ;;
x)	ret=0;;
y)	cd /3/00000000/songs/new;youtube-dl --extract-audio --audio-format mp3 "`xclip -o`";cd ;;
z)	rm -f .autonaumasplayerinput
	wmctrl -s 6 && sleep 3 && xset dpms force off 
	xtrlock & wait
	touch .autonaumasplayerinput && nohup /bin/bash autonaumusPLAYER.sh >/dev/null 2>&1 & 
	eval wmctrl -i -a `env|grep -i "windowid"|egrep -o '[0-9]*'`;;
"!")	(touch .autonaumasplayerinput && nohup /bin/bash autonaumusPLAYER.sh >/dev/null 2>&1 & )  &
	ret=0;;
">")	
	#touch -d "$(($RANDOM%10)) day" /2/Downloads/"`ls -t /2/Downloads/|tail -1`" 
	rm .mplayer_delete
	sed -i '1d' .mplayer_delete_parent
	currentthings 
	ret=0
	;;
"$")	echo -e "\t\t"Space left : `df /2|tail -1|awk '{print $4/1000000}'` GB. Content size: `du -hs /2/Downloads|awk '{print $1}'`
;;
# "+")	displaycurrentlist
86)	displaycurrentlist
;;
"") ret=0
;;
esac

#fi
#SECONDS=0
done





done

#  while true; do xdotool key 0x0031 0xff0d;sleep 1; done

#xmodmap -pk



# q 24 
# w 25 
# e 26 
# r 27 
# t 28 
# y 29 
# u 30 
# i 31 
# o 32 
# p 33 
# a 38 
# s 39 
# d 40 
# f 41 
# g 42 
# h 43 
# j 44 
# k 45 
# l 46 
# z 52 
# x 53 
# c 54 
# v 55 
# b 56 
# n 57 
# m 58 
