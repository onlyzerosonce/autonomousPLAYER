#!/bin/bash
vol=$(amixer sget 'Master' -c 1|tail -1|egrep -io "[[][0-9]%[]]"|egrep -io '[0-9]*')
pulseaudiocontrol() { amixer sget 'Master' -c 1|tail -1|egrep -io "[[]$1%[]]">/dev/null||amixer sset 'Master' "$1"% -c 1; } 
clearinput()            { while read -t 0.1 -s -n1 ; do : ; done ; }
pulseaudiocontrol() { amixer sset 'Master' "$1"% -c 1; } 
#hotcornerLD() { pkill -f m.sh;xdotool mousemove 100 700; } 
hotcornerLD() { terminator; xdotool mousemove 100 700; }
hotcornerRD() { pulseaudiocontrol 0; } 
displaycurrenttorrents()
{
pidof transmission-gtk && 
{
transmission-remote -l >/tmp/.displaycurrentlist$$
timeout 5 zenity --notification --text="`cat /tmp/.displaycurrentlist$$|tail -50`" 2>/dev/null &
} &&
xdotool mousemove 1300 200;
}
displaycurrentlist(){ 	
tac .mplayer_delete_parent>/tmp/.displaycurrentlist$$
tac .mplayer_delete_display|awk '{print "     "$0}'|tail -40>>/tmp/.displaycurrentlist$$
#echo `cat .mplayer_delete_parent|wc -l`/`find /2/Downloads/ -maxdepth 1|egrep -v '/$'|wc -l`>>/tmp/.displaycurrentlist$$
find /2/Downloads/ -type f|wc -l>>/tmp/.displaycurrentlist$$
timeout 5 zenity --notification --text="`cat /tmp/.displaycurrentlist$$|tail -50`" 2>/dev/null &
xdotool mousemove 1100 50;
# pidof transmission-gtk>/dev/null && ( transmission-gtk & ) && sleep 5&& wmctrl -c "transmission"
}
xinput test 12 | while : ;
do 
read line; 
case "$line" in
"motion a[0]=0 a[1]=0" )
wmctrl -c :ACTIVE: 
clearinput
xdotool mousemove 400 100
;;
"motion a[0]=3095 a[1]=0" )
# displaycurrentlist&& xdotool mousemove 1366 0&&{ pgrep -fl id.sh > /dev/null||bash id.sh& }&& sleep 1s;;
displaycurrentlist&&displaycurrenttorrents  # && { pgrep -fl id.sh > /dev/null||bash id.sh& };;
clearinput
;;
"motion a[0]=0 a[1]=211"[789])
clearinput
hotcornerLD;;
# Enable HotcornerRD when you figure out the setting and getting volume by command line
"motion a[0]=3095 a[1]=2117") 
[[ $vol -ne 0 ]]&&xdotool mousemove 1366 768&&hotcornerRD&&vol=0&&sleep 1s&&clearinput;;
#  *)
# [[ $vol -ne 100 ]]&&pulseaudiocontrol 100&&vol=100
# pkill -f id.sh
"motion a[0]=309"[567]" a[1]="[^0]* ) 
vol=`echo $line|cut -f 3 -d=`; vol=$((120-$vol*100/2000)); [ "$vol" -lt 110 ]&&pulseaudiocontrol $vol
;;
esac
done
