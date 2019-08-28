#!/bin/bash

#
# script for daily diary writing. 
# This removes the necessety of the opening the programme 
filename="$HOME"/jrnl/"$(date +%Y%m%d)"
min=5
wid=$(xdotool getactivewindow);
secs=$(($min * 60));
while [ $secs -gt 0 ] && ps -p $$ > /dev/null 2>&1   ; do secs=$((secs-1));
	        xdotool set_window --name "Write please:$secs" $wid; sleep 1; done&

		echo Just write for 5 minutes.>"$filename"
		echo "[ddddi] and write title.">>"$filename"
vim "$filename"

	newfilename="$filename"_"$(head -1 "$filename"|sed 's/ /_/g')".txt
	echo Nice... you made a diary entry today. hurray.
	echo todays entry will be saved as "$newfilename"
	mv "$filename" "$newfilename"
	echo "	Typing stats "
	echo "$(cat $newfilename|wc -m)" letters
	echo "$(cat $newfilename|wc -l)" lines
	echo "Time taken to write $SECONDS seconds"
	echo "$(($(cat $newfilename|wc -m)*60/$SECONDS))" letters per minute
	echo "$(($(cat $newfilename|wc -l)*60/$SECONDS))" lines per minute
	echo "$(($(cat $newfilename|wc -w)*60/$SECONDS))" words per minute
echo "	Waiting for your finish reading those stats [ENTER]"
read 
exit 0
