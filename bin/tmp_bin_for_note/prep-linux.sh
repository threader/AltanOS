#!/bin/bash
echo "Will now prepare for Gnu/Linux.\n Umount and remove your sdcard or this will fail!"
./adblinux kill-server
./adblinux start-server
./adblinux push psnetuer /data/local/tmp/psneuter
./adblinux shell "/data/local/tmp/psneuter"
./adblinux kill-server
./adblinux start-server
./adblinux wait-for-device

echo "Remointing the FS as RW!\n\n"
./adblinux shell "mount -o rw,remount -t ext3 /dev/block/mmcblk1p1 /system"
#./adblinux shell mount -o rw,remount -t yaffs2 /dev/block/mtdblock2 /system
echo "Lets make us Linux compatible.\n"
./adblinux shell "echo "" > /etc/passwd" 
./adblinux shell "mkdir /root/" 
./adblinux shell "busybox adduser -u 0 -g 0 -H -D root"
-/adblinux shell "passwd -d root"
./adblinux shell echo "root::0:0:0:/root:/system/bin/sh" > /etc/passwd" 
./adblinux push ../startnix-s7 /system/bin/startnix-s7
echo "There we go, all done.\n"
