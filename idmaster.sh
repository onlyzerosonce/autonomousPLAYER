#!/bin/bash
vol=$(amixer sget 'Master' -c 1|tail -1|egrep -io "[[][0-9]*%[]]"|egrep -io '[0-9]*')
Y1=0
clearinput()            { while read -t 0.1 -s -n1 ; do : ; done ; }
pulseaudiocontrol() { vol=$((100-("$1"-200)*100/568));amixer sset 'Master' "$vol"% -c 1; 
	timeout 5 zenity --notification --text="VOLUME=$vol" 2>/dev/null &
} 
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
tac .mplayer_delete_display|awk '{print "     "$0}'|tail -20>>/tmp/.displaycurrentlist$$
#echo `cat .mplayer_delete_parent|wc -l`/`find /2/Downloads/ -maxdepth 1|egrep -v '/$'|wc -l`>>/tmp/.displaycurrentlist$$
find /2/Downloads/ -type f|wc -l>>/tmp/.displaycurrentlist$$
timeout 5 zenity --notification --text="`cat /tmp/.displaycurrentlist$$|tail -35`" 2>/dev/null &
xdotool mousemove 1100 50;
# pidof transmission-gtk>/dev/null && ( transmission-gtk & ) && sleep 5&& wmctrl -c "transmission"
}
while : ;
do 
while pidof xtrlock; do sleep 1s;done
eval $(xdotool getmouselocation --shell)	
case $X in
0)
	case $Y in 
		0)
			wmctrl -c :ACTIVE: 
			xdotool mousemove 400 100
			;;
		767)
			hotcornerLD
			;;
	esac
;;
1365)
	case $Y in
		0)
			displaycurrentlist&&displaycurrenttorrents
			;;
		*)
			[ "$Y1" -ne "$Y" ]&&[ "$Y" -gt 200 ]&&pulseaudiocontrol "$Y1"&&Y1=$Y
			echo $Y1 $Y
			amixer sget 'Master' -c 1|tail -1|egrep -io "[[][0-9]*%[]]"|egrep -io '[0-9]*'
			;;
	esac
;;
#[[ $vol -ne 0 ]]&&xdotool mousemove 1366 768&&hotcornerRD&&vol=0&&sleep 1s&&clearinput;;
#"motion a[0]=309"[567]" a[1]="[^0]* ) 
#vol=`echo $line|cut -f 3 -d=`; vol=$((120-$vol*100/2000)); [ "$vol" -lt 110 ]&&pulseaudiocontrol $vol
esac
done
