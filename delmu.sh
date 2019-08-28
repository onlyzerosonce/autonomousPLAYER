#!/bin/bash
number=$1
if [ "$((number))" -eq 0 ] 
then 
number=$((number-1))
fi
#move delmu to screen 2

[ "$1" == "manual" ]||{ wmctrl -ipl && {
while [ -z "$(for i in $(pgrep -fl "delmu.sh"|awk '{print $1}') ; do wmctrl -ipl|grep "$i" ;done|awk '{print $1}')" ] ; do echo garbage; done
wmctrl -ir "$(for i in $(pgrep -fl "delmu.sh"|awk '{print $1}') ; do wmctrl -ipl|grep "$i" ;done|awk '{print $1}')" -t 1
} ; }
# sed -i '1d' .delete
# rm -f .delete

while ! find /3/0*/songs/DriveisLive ; do sleep 15m; done
[ ! -s .delmu_full ] && find /3/0*/songs/* -type f|sort -R>.delmu_full
head -3 .delmu_full>.delete

sed -i '1,3d' .delmu_full

while [ "$number" -ne "0" ]
do

while [[ -s .delete ]]
do 
filename="$(head -1 .delete)"
# timeout 5 zenity --notification --text "`cat .delete|wc -l`:~>`basename "$(tail -1 .delete | head -1)"`"
#timeout 5 zenity --notification --text "`basename "$(tail -1 .delete | head -1)"`" 2>/dev/null &
timeout 5 zenity --notification --text "$(grep "$filename" "$0".fav>/dev/null && echo In Favourite List:)""$(basename "$filename")" 2>/dev/null &

mplayer -use-filename-title -msgcolor -nolirc -softvol -volume 50 "$filename"

clear
echo 
echo
echo
echo    "   the last file being played was "
echo -n "   "
basename "$filename"
echo -n "   "
head -1 .delete
echo 
read -r -t 5 -s -n1  -p "   Choose option 1 for delete,search,favourite,play Favourite??" k
if [ "$k" == 1  ]
then
echo "Deleteing the file $filename"
sleep 5
rm -v "$filename"
clear 
echo "Deleted the file $filename"
sleep 2
fi

if [ "$k" == "F"  ]
then
#cat $0.fav|grep "head -1 .delete" && { { cat $0.fav|grep -v "head -1 .delete" > $0.fav.tmp && mv $0.fav.tmp $0.fav; } || head -1 .delete>>$0.fav; }
grep "$filename" "$0".fav&& { { grep -v "$filename" "$0".fav> "$0".fav.tmp && mv "$0".fav.tmp "$0".fav; } || head -1 .delete>>"$0".fav ; } ;
#head -1 .delete>>$0.fav
fi


if [ "$k" == "f"  ]
then
sort -R "$0".fav > .delete
fi


while [ "$k" == "s"  ]
do
clear
echo "Enter the name of the song:"
read -r expression
echo "Searching the song"
#expression=`echo $expression|sed 's/ /.*/g'`
expression=${expression// /\.*}
find /3/0*/songs/* -type f|grep -iE "$expression">.delete
cat .delete
temp=$k
read -r -t 5 -s -n1 -p " Type s to search again (s/) ??" k
done
#
# [ "$temp" == "s"  ] && mplayer -use-filename-title -msgcolor -nolirc -playlist .delete
# temp="ns"

[ "$temp" != "s"  ] && sed -i '1d' .delete
 temp="ns"
done 

number=$((number-1))
# [ "$k" != "F"  ] && 
# find /3/0*/songs/* -type f|sort -R>.delete
# if [ $(date +%H) -lt 5 ] ; then 

# [ ! -s .delmu_relaxing ] && find /3/00000000/songs/|grep -i 'sleep trance'|sort -R>.delmu_relaxing
[ ! -s .delmu_relaxing ] && find "/3/00000000/songs/Sleep Trance/"|sort -R>.delmu_relaxing


head -3 .delmu_relaxing >>.delete; ## fi;
sed -i '1,3d' .delmu_relaxing;

done
