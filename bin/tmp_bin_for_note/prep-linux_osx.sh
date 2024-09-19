#!/bin/bash
echo "Will now prepare for Gnu/Linux.\n Umount and remove your sdcard or this will fail!"
./adbmac kill-server
./adbmac start-server
./adbmac push psnetuer /data/local/tmp/psneuter
./adbmac shell "/data/local/tmp/psneuter"
./adbmac kill-server
./adbmac start-server
./adbmac wait-for-device

echo "Remointing the FS as RW!\n\n"
./adbmac shell "mount -o rw,remount -t ext3 /dev/block/mmcblk1p1 /system"
#./adbmac shell mount -o rw,remount -t yaffs2 /dev/block/mtdblock2 /system
echo "Lets make us Linux compatible.\n"
./adbmac shell "echo "" > /etc/passwd" 
./adbmac shell "mkdir /root/" 
./adbmac shell "busybox adduser -u 0 -g 0 -H -D root"
-/adbmac shell "passwd -d root"
./adbmac shell echo "root::0:0:0:/root:/system/bin/sh" > /etc/passwd" 
./adbmac push ../startnix-s7 /system/bin/startnix-s7
echo "There we go, all done.\n"
