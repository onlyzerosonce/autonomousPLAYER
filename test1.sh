if wmctrl -m | grep -e "Name:"|grep -iq "awesome" 
	then 
	echo hello
else 
	echo not
fi

