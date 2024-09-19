#/bin/bash
echo "The BackAsswardsRootScript.\n"
echo "Lets start the adblinux server.\n"
echo "Will now prepare for Gnu/Linux.\n Umount and remove your sdcard or this will fail!"
./adblinux kill-server
./adblinux start-server

echo "Pushing the exploit psneuter onto the device.\n\n"
./adblinux push psneuter /data/local/tmp/psneuter
./adblinux shell "chmod 0755 /data/local/tmp/psneuter"
echo "Now we run the root exploit.\n\n"
./adblinux shell "/data/local/tmp/psneuter"
./adblinux kill-server
./adblinux start-server
./adblinux wait-for-device

echo "Remointing the FS as RW!\n\n"
./adblinux shell "mount -o rw,remount -t ext3 /dev/block/mmcblk1p1 /system"
#./adblinux shell mount -o rw,remount -t yaffs2 /dev/block/mtdblock2 /system
echo "Pushing the system files in place\n"
./adblinux push su /system/bin/su
./adblinux push Superuser.apk /system/app/Superuser.apk
./adblinux push busybox /system/bin/busybox
echo "Correct permissions might be nice.\n"
./adblinux shell "chmod 4755 /system/bin/busybox"
./adblinux shell "chmod 4755 /system/bin/su"
./adblinux shell "chmod 755 /system/app/Superuser.apk"

echo "Lets make us Linux compatible.\n"
./adblinux shell "echo "" > /etc/passwd" 
./adblinux shell "mkdir /root/" 
./adblinux shell "busybox adduser -u 0 -g 0 -H -D root"
-/adblinux shell "passwd -d root"
./adblinux shell "echo "root::0:0:0:/root:/system/bin/sh" > /etc/passwd" 
./adblinux push ../startnix-s7 /system/bin/startnix-s7
./adblinux shell "chmod 4755 /system/bin/startnix-s7"
# Lets go back to read only.
echo "Remounting the filesystem as Read-Only\n\n"
./adblinux shell "mount -o ro,remount -t ext3 /dev/block/mmcblk1p1 /system"
echo "You should now be rooted my friend.\n Enjoy!\n"

