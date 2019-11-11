#!/bin/bash
foreachfile () {
SAVEIFS=$IFS
commandpar=$1
shift
IFS=$(echo -en "\n\b")
for f in `ls $*`
do
eval  $commandpar "\"$f\""
done
IFS=$SAVEIFS
}

waitfor () 
{ 
sleep $1;
}

torrentdownloader () { 
dirpm=`pwd`; 
cd /tmp; 
echo ""; 
echo "Okay sir the extraction will begin shortly"; echo "Downloading $1"; 
wget "$1" -O indexpage; 
sleep 1s; clear; 
echo "Following links Found:"; sleep 2s; 
more indexpage|egrep -io '.*(torrent).*'; sleep 2s; echo ""; 
more indexpage|egrep -io 'url.*(torrent)["'"'"']'|egrep -io '[^"]*http://[^"]*';
more indexpage|egrep -io 'url.*(torrent)["'"'"']'|egrep -io '[^"]*http://[^"]*'>indexpage.links; 
echo "`wc -l indexpage.links` links found"; 
while [ -s indexpage.links ]; do 
more indexpage.links|head -1; 
echo; echo; 
link=`more indexpage.links|head -1`; 
file=`echo $link|egrep -o '[^/]*$'`.torrent; 
wget "$link" -O "$file"; 
echo; 
echo; 
echo "opening file :$file"; 
#gnome-open "$file"; 
sed -i '1d' indexpage.links; 
echo; 
echo "`wc -l indexpage.links` links to download"; 
echo; done; 
transmission-gtk *.[tToOrReEnNtT]; 
cd "$dirpm"; 
}


extractimages () {
echo ""
sleep 1s
echo "Okay sir the extraction will begin shortly"
echo "Downloading $1"
wget "$1" -O indexpage
sleep 1s
clear 
echo "Following links Found:"
sleep 2s
more indexpage|egrep -io '["'"'"'].[^"'"'"']*(jpg|jpeg|jpe|gif|png|bmp)["'"'"']'
sleep 2s
echo ""
echo "links to download (removing thumb links)"
more indexpage|egrep -io '["'"'"'].[^"'"'"']*(jpg|jpeg|jpe|gif|png|bmp)["'"'"']'|grep -v /thumb/|grep -o '[^"'"'"']*'
more indexpage|egrep -io '["'"'"'].[^"'"'"']*(jpg|jpeg|jpe|gif|png|bmp)["'"'"']'|grep -v /thumb/|grep -o '[^"'"'"']*'>indexpage.links
echo "`wc -l indexpage.links` links found"
while [ "$((`more indexpage.links|wc -l|bc`))" -ne "0" ]
do
more indexpage.links|head -1
echo 
echo 
link=`more indexpage.links|head -1`
file=`echo $link|egrep -o '[^/]*$'`
wget -c "$link"
echo 
echo
echo "opening file :$file"
gnome-open "$file" 
sed -i '1d' indexpage.links
echo
echo "`wc -l indexpage.links` links to download"
echo
done
}
#wget "`more indexpage|egrep -io '["'"'"'].[^"'"'"']*jpg["'"'"']'|grep -v /thumb/|grep -o '[^"'"'"']*'`"

#########################################
extracttitlesfromrss()
{
wget "$1" -O $$page.html
more $$page.html |egrep -io '<title>[^<]*</title>'|egrep -io '>.*<'|egrep -io '[^<>]*'|grep -iv 'Google News'|sed "s/&apos;/'/g"|sed 's/&amp;/\&/g'
rm $$page.html
}
findanicon ()
{
nop=/3/pics/notify.jpeg
a="$*";
totem-video-thumbnailer "$a" ".thumbnails/large/t.png"&&nop="$HOME/.thumbnails/large/t.png"
#evince-thumbnailer
echo $nop
}

findwindow ()
{
wmctrl -l |grep -i "$1"
}

readnews() { 
[ -s read.page ] && amixer sset 'Master' 50%
while [ -s read.page ]
do 
eval wmctrl -i -a `env|grep -i "windowid"|egrep -o '[0-9]*'`
#[ "`head -1 read.page|wc -w`" -gt 3 ]&&notify-send -u critical "News" "`head -1 read.page`" -i /3/pics/notify.jpeg;
echo -ne "\e[1;32m"
echo -n `more read.page|wc -l`
echo -ne "\e[0m:"
head -1 read.page
# espeak -s 120f  "`head -1 read.page`" 2>/dev/null
espeak `[[ $(($RANDOM%2)) -ne 0 ]] && echo || echo '-ven-us+f4'` -s 120f  "`head -1 read.page`" 2>/dev/null
sed -i '1d' read.page;
done
 }

#echo $0.whenranhistory
#touch $0.whenranhistory
#. $0.whenranhistory
#echo "$PROG$0" -ne "`date +%d|bc`"
#if [ ! "$PROG$0" -ne "`date +%d|bc`" ] 
#then
#echo "PROG$0=`date +%d`"> $0.whenranhistory
#fi

#sleep 10
sendtophone ()

{


while (( "$#" )); do

presentdir=`pwd`
dest=/tmp/"$(basename "$1")"
cp -v "$1" /tmp/"$(basename "$1")"


cd /tmp
basenameoffile="$(basename "$1")"

destination="./FROMPC/""$basenameoffile"


echo put \""$basenameoffile"\" \""$destination"\"| ftp -v 192.168.0.100 5544


cd "$presentdir"
shift
done
}
mcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
#echo $DESKTOP_SESSION

lengthofmovie(){ mplayer -vo null -ao null -identify -frames 0 "$1" 2>/dev/null|egrep -io 'id_length.*'|egrep -io '[0-9.]*'|egrep -io '[0-9]*'|head -1&&echo 0|bc;}

function afterinstall(){
#!/bin/bash
#for flash 
#sudo apt-add-repository "deb ftp://ftp.debian.org/debian stable main contrib non-free"
sudo dpkg --add-architecture i386 # for android development
sudo apt-get update
sudo apt-get install zenity elinks eog flashplugin-nonfree vim mplayer libnotify-bin espeak wmctrl icedtea-7-plugin openjdk-6-jre-headless transmission-remote-cli pdftk eclipse djvulibre-bin python-pip wkhtmltopdf sqlite3 artha xdotool unrar p7zip-full thunar calibre terminator
 libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 
 
 # for android libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386  and  dpkg --add-architecture i386
pip install flexget # edit $HOME/config.yml
cp $HOME/.flexget/config.yml $HOME/config.yml_"`date`"
#had problems with nvidea drivers and they always make something happen so ... $ aptitude -r install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') nvidia-kernel-legacy-173xx-dkms

## using super user for configuring the nvidea
# mkdir /etc/X11/xorg.conf.d
# echo -e 'Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf
}
function autobackup () {
fbk=`find "$0" -maxdepth 0 -printf "%f_%TY%Tm%Td%TH%TM"`
[ ! -f "$fbk" ] && cp "$0" "$fbk" 
}
function autobackup1 () {
fbk=`find "$1" -maxdepth 0 -printf "%f_%TY%Tm%Td%TH%TM"`
#[ ! -f "$fbk" ] && cp "$1" "$fbk" 
[ ! -f "$fbk" ] && cp "$1" "$fbk" && echo "#bakupfilename=$fbk">>"$fbk"
# or && cp "$1" "$fbk" 
}
autobackup1 $HOME/.bashrc
autobackup1 $HOME/.bash_aliases
autobackup1 $HOME/m.sh
autobackup1 $HOME/delmu.sh
autobackup1 "$0"

datediff() { a="$(date -d "$1" +%s)";
b="$(date -d "$2" +%s)";
echo "$a-$b"|bc; 
};


#lengthofmovie(){ mplayer -vo null -ao null -identify -frames 0 "$1" 2>/dev/null|egrep -io 'id_length.*'|egrep -io '[0-9.]*'|egrep -io '[0-9]*'|head -1;}



deleteemptyfiles () {

find "$1" -empty -type d -delete;

}


wake () {
#read -t 3 -s -n1 -p "	 		or leftist for search? " k
read -t $1 -s -n1 -p "$2" k
}
