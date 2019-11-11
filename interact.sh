#!/bin/bash
# set -euo pipefail
# IFS=$'\n\t' 
########## variables
a="$1"
[ "$a" == "" ]  && a="ParameterNotPassed"
firstrun=0
##########


appendattop () { echo "$2" | cat - "$1" > "/tmp/appendattop.$$" && mv "/tmp/appendattop.$$" "$1" ; }



function autobackup () { fbk=`find "$0" -maxdepth 0 -printf "%f_%TY%Tm%Td%TH%TM"` && [ ! -f "$fbk" ] && cp "$0" "$fbk" && echo "#bakupfilename=$fbk">>"$fbk"; }
autobackup

displaycurrentlist()		{ 	tac .mplayer_delete_parent>/tmp/.displaycurrentlist$$
						tac .mplayer_delete_display|awk '{print "     "$0}'|tail -40>>/tmp/.displaycurrentlist$$
						#cat .mplayer_delete_parent|wc -l >>/tmp/.displaycurrentlist$$
						echo `cat .mplayer_delete_parent|wc -l`/`find /2/Downloads/ -maxdepth 1|egrep -v '/$'|wc -l`>>/tmp/.displaycurrentlist$$
						timeout 5 zenity --notification --text="`cat /tmp/.displaycurrentlist$$|tail -50`" 2>/dev/null &
						tail -50 /tmp/.displaycurrentlist$$
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

while [ "$a" != "x" ]  && [ "$a" != "" ] 
do
[ "$firstrun" != 0 ] && [ -n "$a" ] && echo You pressed \""$a"\"
read -s -n1 -p "`date` ~>" a # a=`getch`
[ "$firstrun" == 0 ] && firstrun=1

case "$a" in 
a) 	echo aborting ;
#bash learningbashmanual.sh 
exec aborting_some_junk_that_should_not_be_repeated_elsewhere 2>/dev/null;;
A) 	(bash ./android-studio/bin/studio.sh & );;
b)	terminator & ;;
d) 	read link; [ ! -z "$link" ] && wget "$link" && notify-send -u critical "Download complete" -i /3/pics/notify.jpeg;;
c)	(nohup chromium-browser --start-maximized > /dev/null 2>&1 ) & ;;
D) 	bash $HOME/autonomousPLAYER/.ShowCurrentWallp;;
e) 	(scite &) ;;
f) 	(firefox>/dev/null &) ;;
g) 	(gimp&);;
G)	(firefox -search "`xclip -o`" &);;
H)	(echo -100000 > .maxmovietime) ;;
k)	rm -f .autonaumasplayerinput
pkill -f idmaster.sh
killall conky;;
l)	(localc >/dev/null &) &
sleep 5s
exit
;;

L) 	cat $0|grep -io '.*).*';;
m) 	(exec terminator -x /bin/bash $HOME/autonomousPLAYER/m.sh &)  ;;
n) 	(firefox naukri.com&) ;;
o) 	delvariableindel=$(zenity --title="Select a file to 0pen" --file-selection --filename="`cat .historyofopenedfiles|tail -1`");[ -n "$delvariableindel" ] && echo $delvariableindel>>.historyofopenedfiles;[ -n "$delvariableindel" ] && gnome-open "$delvariableindel" ;;
O)	scite $0;;
p)	read -p "Add your priority task:" p && { [ "$p" ] && echo $p>>todo;[ ! "$p" ] && scite todo ;};;
P)	
	firefox "http://www.pornhub.com";;
r)	mv -v /2/Downloads/.DeletedItems/file.Content "`cat /2/Downloads/.DeletedItems/file.Name`";;		
s)	read -p "What do you want to search?" a && firefox -search "$a" ;;
#touch .autonaumasplayerinput && bash autonaumusPLAYER.sh& ;;
S)	sudo shutdown -h now ;;
t)	{ ls /2/.DeletedItems/|wc -l | grep -v 100; } && { thunar /2/.DeletedItems/ & } || { thunar /2/Downloads/ & } ;;
# T) 	transmission-remote-cli;;
T)	telegram-desktop&;;
u)	echo "Going to update and upgrade";sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt autoremove # && sudo pip install --upgrade flexget
;;
v) 	(exec terminator -x alsamixer &) ;;
x)	ret=0;;
y)	cd /3/00000000/songs/new;youtube-dl --extract-audio --audio-format mp3 "`xclip -o`";cd ;;
z)	# rm -f .autonaumasplayerinput
	wmctrl -s 6 && sleep 3 && xset dpms force off 
	xtrlock & wait
	a="x"
#	touch .autonaumasplayerinput && nohup /bin/bash autonaumusPLAYER.sh >/dev/null 2>&1 & 
#	eval wmctrl -i -a `env|grep -i "windowid"|egrep -o '[0-9]*'`;;
;;
"!") #	(touch .autonaumasplayerinput && nohup /bin/bash autonaumusPLAYER.sh >/dev/null 2>&1 & )  &
rm /tmp/.auto-n-lock
exec bash $HOME/autonomousPLAYER/startup.sh 
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
"+")	displaycurrentlist
;;
"") ret=0
;;
esac
done
