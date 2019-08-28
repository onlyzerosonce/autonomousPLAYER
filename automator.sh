#!/bin/bash 

##################################################
##################################################
## This script is for helping me to organize things. 
## And put the mundane things out of my head to in a script so that I can just do the tasks.
## This script will be evoked at startup and will guide me in doing essential things.
##################################################
##################################################

# Upon switching on Laptop.

#move to 4rth workspace
sleep 5s
wmctrl -ir "$(for i in $PPID ; do wmctrl -ipl|grep "$i" ;done|awk '{print $1}')" -t 3

clear 
echo "	This is the startup of the automator."
echo "	Please freshen up I will play music till then at 50% volume."
echo "	"

echo -e "	[ When you are done please press ENTER or any other key ] \n"

echo "	"

acpi -a|grep -E 'on-line' >/dev/null 2>&1 || echo "	Please switch on the power supply of the device."

##read 
wmctrl -s 3
min=5
wid=$(xdotool getactivewindow);
secs=$(($min * 60));
while [ $secs -gt 0 ] && ps -p $$ > /dev/null 2>&1   ; do secs=$((secs-1));
	xdotool set_window --name "Water :$secs" $wid; sleep 1; done&
echo "	Please Enter if you finished filling your water bottles "
	read 
	echo 	You saved "$(($secs-$SECONDS))" SECONDS in this $min min actitivity.
echo "Starting in 5 seconds"

while : 
do
	read -r -t 5 -s -n1 -p "Press i to write the journal entry :" k
	if [ "$k" == "i" ] 
	then 
		clear
		wmctrl -s 3
		/bin/bash +x "$HOME"/dailydiary.sh
		clear
	fi
clear
terminator -p Transparent --geometry 800x600+5+25 -x /bin/bash "$HOME"/m.sh 
sleep 5s
	while pgrep -fl m.sh > /dev/null 2>&1
	do 
		sleep 10s
	done

wmctrl -s 4
chromium-browser --start-maximized > /dev/null 2>&1
clear
wmctrl -s 0

done
exit 0
