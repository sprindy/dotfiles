#!/bin/bash

#Ubuntu 14.04LTS
sudo apt-get install \
	git-core gnupg flex bison gperf build-essential \
	zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
	lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
	libgl1-mesa-dev libxml2-utils xsltproc unzip

#Usefull
sudo apt-get install \
	vim android-tools-adb \
	ssh make python-networkx \
	zlib1g-dev:i386 lib32stdc++6 lib32bz2-1.0 \
	git gitk meld \  #patch relate
	ruby tree\  	   #(make[1]: ruby: Command not found) 
	squashfs-tools \#mksquashfs
	ctags global \  #gtags
	samba smbclient silversearcher-ag \
	python-usb
