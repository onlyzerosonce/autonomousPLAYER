#!/bin/bash

killeverythingAndexit() {
	echo "killing music"
	kill "$(xprop -name bash|grep -iEo 'PID.*'|grep -iEo '[0-9]*')"
	echo "exiting now . bye bye "
	exit ;
}
while : ; do
	###################################### <exiting formalities> #####################################
	[ ! -f .keepplayinginput ] && killeverythingAndexit
	###################################### </exiting formalities> #####################################
	# pgrep -fl delmu.sh || { [ "$(pacmd list-sink-inputs|grep -iEo '(running|drained)'|wc -l)" -eq "0" ] && { xterm -e /bin/bash "$HOME"/delmu.sh& } }
	pgrep -fl delmu.sh || pacmd list-sink-inputs|grep -iEo '(running|drained)' ||  xterm -e /bin/bash "$HOME"/delmu.sh& 

if [ $((0$(pacmd list-sink-inputs|grep -iEo '(bell event|running)'|awk '{ for(i=1; i<=NF; i++) if(tolower($i)=="running") c++ ;else if(tolower($i)=="bell") c-- } END{ print c }'))) -gt "1" ] ; then
	pkill -f delmu.sh 
fi
	sleep 10
done 
# 2>&1 |more>$0.log

