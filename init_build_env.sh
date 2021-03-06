#!/bin/bash

#Ubuntu 14.04LTS
sudo apt-get install \
	git-core gnupg flex bison gperf build-essential \
	zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
	lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
	libgl1-mesa-dev libxml2-utils xsltproc unzip

#Usefull
# gtags:download from http://www.gnu.org/software/global/download.html and sudo make install
sudo apt-get install \
	vim android-tools-adb \
	ssh make autoconf python-networkx \
	zlib1g-dev:i386 lib32stdc++6 lib32bz2-1.0 \
	git gitk meld \
	ruby tree dos2unix \
	squashfs-tools \
	ctags texinfo \
	samba smbclient silversearcher-ag \
	python-usb

# Fix for auto complete in adb command.
# https://github.com/mbrubeck/android-completion/blob/master/android
sudo cp ./bin/adb.txt /bin/
	echo "if [ -e /bin/adb.txt ] ; then" >> /home/sprindy/.bashrc
	echo "  source /bin/adb.txt" 		 >> /home/sprindy/.bashrc
	echo "fi" 							 >> /home/sprindy/.bashrc
source ~/.bashrc
