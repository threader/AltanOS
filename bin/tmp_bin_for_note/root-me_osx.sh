#/bin/bash
echo "The BackAsswardsRootScript.\n"
echo "Lets start the adbmac server.\n"
echo "Will now prepare for Gnu/Linux.\n Umount and remove your sdcard or this will fail!"
./adbmac kill-server
./adbmac start-server

echo "Pushing the exploit psneuter onto the device.\n\n"
./adbmac push psneuter /data/local/tmp/psneuter
./adbmac shell "chmod 0755 /data/local/tmp/psneuter"
echo "Now we run the root exploit.\n\n"
./adbmac shell "/data/local/tmp/psneuter"
./adbmac kill-server
./adbmac start-server
./adbmac wait-for-device

echo "Remointing the FS as RW!\n\n"
./adbmac shell "mount -o rw,remount -t ext3 /dev/block/mmcblk1p1 /system"
#./adbmac shell mount -o rw,remount -t yaffs2 /dev/block/mtdblock2 /system # For now untested , not gamlging. 
echo "Pushing the system files in place\n"
./adbmac push su /system/bin/su
./adbmac push Superuser.apk /system/app/Superuser.apk
./adbmac push busybox /system/bin/busybox
echo "Correct permissions might be nice.\n"
./adbmac shell "chmod 4755 /system/bin/busybox"
./adbmac shell "chmod 4755 /system/bin/su"
./adbmac shell "chmod 755 /system/app/Superuser.apk"

echo "Lets make us Linux compatible.\n"
./adbmac shell "echo "" > /etc/passwd" 
./adbmac shell "mkdir /root/" 
./adbmac shell "busybox adduser -u 0 -g 0 -H -D root"
-/adbmac shell "passwd -d root"
./adbmac shell "echo "root::0:0:0:/root:/system/bin/sh" > /etc/passwd" 
./adbmac push ../startnix-s7 /system/bin/startnix-s7
./adbmac shell "chmod 4755 /system/bin/startnix-s7"
# Lets go back to read only.
echo "Remounting the filesystem as Read-Only\n\n"
./adbmac shell "mount -o ro,remount -t ext3 /dev/block/mmcblk1p1 /system"
echo "You should now be rooted my friend.\n Enjoy!\n"

