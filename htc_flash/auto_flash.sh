#!/bin/bash

sudo adb shell reboot bootloader && sleep 3 &&
sudo htc_fastboot oem rebootRUU && sleep 3 &&

boot_img=`ls | grep "BOOT"`
if [ -e "$boot_img" ]; then
	echo "flash Boot rom: $boot_img"
	sudo htc_fastboot flash zip $Boot && sleep 3 &&
fi

partial=`ls | grep "partial"`
if [ -e "$partial" ]; then
	echo "flash partial rom: $partial" &&
	ret=`sudo htc_fastboot flash zip $partial`
	if [ $? -eq 0 ]
	then
		echo "flash partical ok"
	else
		# flash again to fix partial rom flash error.
		ret=`sudo htc_fastboot flash zip $partial`
	fi

   	sleep 3
else
	echo "no partial rom, skip"
fi

signed=`ls | grep "signed"`
if [ -e "$signed" ];then
	echo "flash signed rom: $signed"
	sudo htc_fastboot flash zip $signed && sleep 3
else
	echo "no signed rom, exit"
	exit 0
fi


sudo htc_fastboot reboot


