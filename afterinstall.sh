#!/bin/bash
#for flash 
#sudo apt-add-repository "deb ftp://ftp.debian.org/debian stable main contrib non-free"
# apt-get update
apt install elinks xtrlock p7zip-full
apt install eog
apt install flashplugin-installer
apt install vim mplayer libnotify-bin 
apt install espeak 
apt install wmctrl
apt install transmission-remote-cli transmission-gtk scite
apt install djvulibre-bin # for djvu2pdf
#apt-get install python-pip 
#pip install flexget # edit $HOME/config.yml
#pip install hackertray
apt install wkhtmltopdf 

apt install sqlite3
# for android
#dpkg --add-architecture i386
#apt-get install libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386
apt install unrar
apt install xdotool
apt install calibre
# had problems with nvidea drivers and they always make something happen so ... $ aptitude -r install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') nvidia-kernel-legacy-173xx-dkms
# libgnome2-0 for gnome-open
apt install artha chm2pdf clipit libgnome2-0 
## using super user for configuring the nvidea
# mkdir /etc/X11/xorg.conf.d
# echo -e 'Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf

apt install xcompmgr #for window transparancy
apt install acpi # for power supply related queries.
apt install xterm
apt install conky curl lm-sensors hddtemp
apt install libgnome2-bin
