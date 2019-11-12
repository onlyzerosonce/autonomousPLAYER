#!/bin/bash
#zenity --info --text "What is the most needed thing right now. Do you know that?"
#trap "pgrep -fl 'm.sh'||{ echo exec terminator -p Transparent --geometry 800x600+5+25 -x /bin/bash $HOME/m.sh>.temp.sh;[ ! -f .autonaumasplayerinput ]||bash .temp.sh }" EXIT
# . .bashrc
source autonomousPLAYER/functions.sh
# for debugging 
# set -euo pipefail
# IFS=$'\n\t' 
sleep 5s
# wmctrl -ir $(for i in `pgrep -fl "m.sh"|awk '{print $1}'` ; do wmctrl -ipl|grep "$i" ;done|awk '{print $1}') -t 0
wmctrl -ir "$(for i in $PPID ; do wmctrl -ipl|grep "$i" ;done|awk '{print $1}')" -t 0

[ -s /2/Downloads ] || read -r -p "You dont have any thing at that path " 

filename(){
tail -"${n:-1}" .mplayer_delete | head -1
}

#ping facebook.com && bash /home/v/MyScripts/checkwikiupdates.sh 
#elinks facebook.com | egrep -i login && bash /home/v/MyScripts/checkwikiupdates.sh 


echo "q w e r
a s d f
z x c v
">left.kb
sizeoffile()			{ [ ! -e "$1" ]&&{ echo 0|| stat --printf="%s" "$1"; } ; }
sizeoffileMB()			{ [ ! -e "$1" ]&&{ echo 0|| stat --printf="%s" "$1"|awk '{print $1"/1000000"}'|bc;};}
sizepopup()			{ sleep 5s ; timeout 5 zenity --notification --text="length of movie~>""$(lengthofmovie "$(filename)"|head -1|awk '{print $1"/60"}'|bc)"":""$(printf "%02d" "$(lengthofmovie "$(filename)"|head -1|awk '{print $1"%60"}'|bc)")" 2>/dev/null & }
displayspaceleft()		{ timeout 5 zenity --notification --text="Space left : $(df /2|tail -1|awk '{print $4/1000000}') G. Size of Content: $(du -hs /2/Downloads|awk '{print $1}')" 2>/dev/null & }
displaycurrentitem()	{ timeout 5 zenity --notification --text="$CurrentFile" 2>/dev/null & } 
displaycurrentlist()		{ 	
						tac .mplayer_delete_parent>/tmp/.displaycurrentlist$$
						tac .mplayer_delete_display|awk '{print "     "$0}'>>/tmp/.displaycurrentlist$$
						echo "$(wc -l .mplayer_delete_parent)"/"$(find /2/Downloads/ -maxdepth 1|grep -vEc '/$')">>/tmp/.displaycurrentlist$$
						timeout 5 zenity --notification --text="$(tail -30 /tmp/.displaycurrentlist$$)" 2>/dev/null &
						}
appendattop () { echo "$2" | cat - "$1" > "/tmp/appendattop.$$" && mv "/tmp/appendattop.$$" "$1" ; }
backupfile(){ 
		BakupDir="/2/.DeletedItems"
		mkdir -p "$BakupDir"
		DepthOfBackup=100
		[[ "$1" == "move" ]] && mv "$(filename)" $BakupDir/"$(date +%s)"_"$(basename "$(filename)")"  
		[[ "$1" == "copy" ]] && cp "$(filename)" $BakupDir/"$(date +%s)"_"$(basename "$(filename)")"  
		while [ "$(find "$BakupDir" -type f|wc -l)" -gt "$DepthOfBackup" ] ; do rm "$(find "$BakupDir" -type f|sort|head -1)" ; done
#		pgrep -fl sleep10m.sh >/dev/null||bash browseMidori.sh 2>/dev/null &
		
pgrep -fl browseMidori.sh >/dev/null&&while ! pgrep -fl sleep10m.sh >/dev/null
		do 
		sleep 5s
		done

		}

waittillinputorinterrupt1(){ 
	filename=$(basename "$1")
	while pgrep -fl "$filename"
	do
	sleep 2s
	done;
}

#function delfirstandrefillifempty(){
#sed -i '1d' .mplayer_delete_parent
#[ ! -s .mplayer_delete_parent ]&&find /2/Downloads/ -maxdepth 1|sort -r | grep -v '^/2/Downloads/$'|sort -R>.mplayer_delete_parent
#echo
#}

function delfirstandrefillifempty(){
sed -i '1d' .mplayer_delete_parent
[ ! -s .mplayer_delete_parent ]&&python3 "$HOME"/autonomousPLAYER/readingcount.py
echo
}


function doyouwantthis(){
clear
head -6 .mplayer_delete_parent
k=""
read -r -t 3 -s -n1 -p "                   skip it by >" k
[ "$k" = ">" ] && delfirstandrefillifempty && doyouwantthis 
#[ "$k" = ">" ] && sed -i '1d' .mplayer_delete_parent && doyouwantthis 
echo  
}

function refreshplaylist(){ 
#sed -i '1d' .mplayer_delete_parent
#[ ! -s .mplayer_delete_parent ]&&find /2/Downloads/ -maxdepth 1|sort -r | grep -v '^/2/Downloads/$'|sort -R>.mplayer_delete_parent
delfirstandrefillifempty
doyouwantthis

head -1 .mplayer_delete_parent
k=""
read -r -t 3 -s -n1 -p "	 		or leftist for search? " k
	while [ -n "$k" ] && grep -q "$k" left.kb 2>/dev/null
	do
		clear 
		read -r -p "Enter the expression:" expression
		expression=${expression// /\.*}
		echo "Searching the Item"
		find /2/Downloads/ -type f |grep -iE "$expression"|sort -h | tee .mplayer_delete
		read  -r -t 3 -s -n1 -p "		leftist for search ? " k
		itsearched="1"
	done
	[ -z "$itsearched" ] && find "$(head -1 .mplayer_delete_parent)" -type f| sort -h>.mplayer_delete;			

itsearched=""

displaycurrentlist
echo -e "\n\nDeleting empty folders." && find /2/Downloads/ -depth -type d -empty -delete
mkdir -p /2/Downloads/0.SelfImprovement
mkdir -p /2/Downloads/1.ML
mkdir -p /2/Downloads/2.Programming
mkdir -p /2/Downloads/3.Investment
mkdir -p /2/Downloads/4.SkillPolish
mkdir -p /2/Downloads/5.Entertainment
}

function deletepage () {  
		backupfile "copy"
		echo "You entered number of pages to be deleted = $nop"
		sleep 10s
		echo "$nop""|$(date +%Y%m%d)|""$1" | tee -a .readingstats
		deletepageexitstatus=0
		
		[ "$deletepageexitstatus" -eq "0" ] && mimetype -b "$1"|grep 'image/vnd.djvu' 2>/dev/null && { for i in $(seq 1  1 "$nop") ;do djvm -d "$1" 1 ; done } && mv "$1" temp.djvu && mv temp.djvu "$1" &&  deletepageexitstatus=1;
		[ "$deletepageexitstatus" -eq "0" ] && mimetype -b "$1"|grep 'application/pdf' 2>/dev/null && gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage="$((nop+1))" -sOutputFile=temp.pdf "$1" && mv temp.pdf "$1" && deletepageexitstatus=1;
		# [ "$deletepageexitstatus" -eq "0" ] && mimetype -b "$1"|grep 'application/pdf' 2>/dev/null && pdftk "$1" cat "$((nop+1))"-end output temp.pdf && mv temp.pdf "$1" && deletepageexitstatus=1; 
		true > .mplayer_delete
		wake 3
		return $deletepageexitstatus; 
}

deletefile(){		
		timeout 1 zenity --notification --text="Size of file=$(sizeoffileMB "$(filename)")MB" 2>/dev/null &
		timeout 5 zenity --notification --text="Deleteing the file $(filename)" 2>/dev/null  &
		echo "Deleteing the file $(filename)"
		backupfile "move"
		clear  
		timeout 5 zenity --notification --text="Deleted the file $(filename)" 2>/dev/null &
		echo "Deleted the file $(filename)"
		displayspaceleft
		displaycurrentlist
		}
		
checkxclip() { 
	xclipselection="$(xclip -o 2>/dev/null)"; #echo "Select delete word here by double clicking it in next 5 seconds" ;
		xclip -i <<tillend
tillend
xclipselectionnew="$(xclip -o 2>/dev/null)"
[[ "$xclipselection" != "$xclipselectionnew" ]]&&[[ "$xclipselection" = "delete" ]]
} ;

get_choices_and_process(){
	# backupfile
	clear 
	k=""
	echo "$CurrentFile"
input=""

echo "	1. delete"
echo "	2. two"
echo "	3. three"
echo "	4. four"
echo "	5. five"
echo "	6. six"
echo "	7. seven"
echo "	8. eight"
echo "	9. nine"
	read -r -t 5 -s -n1 -p "Press 1 to delete or mouse over delete :" k
	echo
	[ "$k" = "" ]&& xdotool click --repeat 2 1 && input=$(xclip -o)&&
(
xclip -i<< EOT
EOT
)&&
case $input in 
"delete") k="1";;
"two")k="2";;
"three")k="3";;
"four")k="4";;
"five")k="5";;
"six")k="6";;
"seven")k="7";;
"eight")k="8";;
"nine")k="9";;
esac

[ $k -eq "9" ] && read -r -t 5 -p " Enter the number of pages (default 9):" k && k=${k:-9}

	if [ "$k" -eq "$k" ] 2>/dev/null;
		then
		nop=$k
		head -1 .mplayer_delete|grep -iE '(pdf|djvu)$'  > /dev/null
		tempstatus="$?"
		if [ "$tempstatus" -eq "0" ] 
			then
				head -1 .mplayer_delete|grep -iE '(pdf)$' > /dev/null && pagespresent=$(pdfinfo "$(filename)"| grep -a Pages:|awk '{print $2}')
				head -1 .mplayer_delete|grep -iE '(djvu)$'> /dev/null && djvm -c test1forpagenumber.djvu "$(filename)" "$(filename)" && pagespresent=$(($(djvm -l test1forpagenumber.djvu | grep -iEo '#[0-9]*'|grep -iEo '[0-9]*' |tail -1)/2))&& rm -f  test1forpagenumber.djvu
			if [[ "$pagespresent" -le "$nop" ]]
				then 
				echo "$pagespresent""|$(date +%Y%m%d)|""$(filename)" | tee -a .readingstats
				deletefile "$(filename)"
			else 
				deletepage "$(filename)"
				fi
			fi
		[ -e "$(filename)" ] && echo "$(lengthofmovie "$(filename)"| head -1 |awk '{print $1"/300+1"}'|bc)""|$(date +%Y%m%d)|""$(filename)" | tee -a .readingstats
		deletefile "$(filename)"
		else 
		[ "$k" == ">" ] && true > .mplayer_delete
		fi
[ "$k" == "r" ] && read -r -e -i "$(filename)" NewFileName && mv "$(filename)" "$NewFileName" && unset NewFileName 
	k=""
}

###############################################################################
while :
do
 clear 
# refreshplaylist
n=$(wc -l <.mplayer_delete)
tail -"$n" .mplayer_delete >.mplayer_delete_display

while [ "$n" -gt 0 ];
do 

	CurrentFile="$(tail -"$n" .mplayer_delete | head -1)"
	[ ! -f "$CurrentFile" ] && refreshplaylist&&n=$(wc -l <.mplayer_delete)&&CurrentFile="$(tail -"$n" .mplayer_delete | head -1)"
tail -"$n" .mplayer_delete >.mplayer_delete_display
displaycurrentlist
displaycurrentitem

clear  
# bash autobrowse.sh

	mimetype -b "$CurrentFile" | grep -iEq 'audio' || wmctrl -s 2
	[ ! -s "$CurrentFile".pdf ] && wmctrl -s -d 1 && echo "$CurrentFile"|grep -iE '\.epub|\.mobi' && ebook-convert "$CurrentFile" "${CurrentFile%.*}.pdf"
	mimetype -b "$CurrentFile"|grep 'text/html' && wkhtmltopdf "$CurrentFile" "${CurrentFile%.*}".pdf && deletefile "$CurrentFile" && evince "${CurrentFile%.*}".pdf &  wait 
	echo "$CurrentFile" | grep -iE '\.pdf|\.djvu'&& evince -i '1' "$CurrentFile"	 &  wait 
	echo "$CurrentFile" | grep -iE '\.jpg|\.png'  && eog --fullscreen "$CurrentFile" &  wait 
	echo "$CurrentFile" | grep -iE '\.doc|\.cbr|\.cbz|.txt|.gif' && gnome-open "$CurrentFile"&&waittillinputorinterrupt1 "$CurrentFile"
	echo "$CurrentFile" | grep -iE '\.zip|\.rar|\.7z' && wmctrl -s -d 1 && mkdir -p "${CurrentFile%.*}" && 7z x "$CurrentFile" -o"${CurrentFile%.*}" && deletefile "$CurrentFile"
	
#	readnews

	sizepopup&
	basename "$CurrentFile">.mplayer_currentfile
	# (echo "$CurrentFile" | egrep -i '\.mp3' && mimetype "$CurrentFile" | egrep -i "audio" )||wmctrl -s 2
	mimetype -b "$CurrentFile" | grep -iEq 'audio' || wmctrl -s 2
	echo "$CurrentFile" | grep -iE '\.vlc' && vlc --play-and-exit "$CurrentFile" 
	mplayer -fs -af scaletempo volume="${v:=10}:0" -use-filename-title -msgcolor -nolirc -sub-fuzziness 2 "$CurrentFile" 2>/dev/null;
	sleep 1s
	wmctrl -s -d 1
	#eval wmctrl -i -a `env|grep -i "windowid"|egrep -o '[0-9]*'`
	xdotool mousemove 200 200
	echo
	get_choices_and_process
	echo
	n=$((n-1))
	done
	refreshplaylist
	done

# mplayer -vo fbdev2 /*or fbgs */-zoom -x 1366 -y 768 /2/Downloads/David.Letterman.2013.11.21.Jonah.Hill.HDTV.x264-2HD.mp4
#bakupfilename=m.sh_201710140822
