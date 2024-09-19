REM Used TRZ as reference for windows version, thanks
echo The BackAsswardsRootScript.
echo Lets start the adb server.
echo Will now prepare for Gnu/Linux. Umount and remove your sdcard or this will fail!
adb.exe kill-server
adb.exe start-server

echo Pushing the exploit psneuter onto the device.
adb.exe push psnetuer /data/local/tmp/psneuter
adb.exe shell "chmod 0755 /data/local/tmp/psneuter"
echo Now we run the root exploit.
adb.exe shell "/data/local/tmp/psneuter"
adb.exe kill-server
adb.exe start-server
adb.exe wait-for-device

echo "Remointing the FS as RW!\n\n"
adb.exe shell "mount -o rw,remount -t ext3 /dev/block/mmcblk1p1 /system
REM adb.exe shell mount -o rw,remount -t yaffs2 /dev/block/mtdblock2 /system
echo "Pushing the system files in place\n"
adb.exe push su /system/bin/su
adb.exe push Superuser.apk /system/app/Superuser.apk
adb.exe push busybox /system/bin/busybox
echo "Correct permissions might be nice.\n"
adb.exe shell "chmod 4755 /system/bin/busybox"
adb.exe shell "chmod 4755 /system/bin/su"
adb.exe shell "chmod 755 /system/app/Superuser.apk"

echo Lets make us Linux compatible.
adb.exe shell "echo "" > /etc/passwd" 
adb.exe shell "mkdir /root/" 
adb.exe shell "busybox adduser -u 0 -g 0 -H -D root"
adb.exe shell "passwd -d root"
adb.exe shell "echo "root::0:0:0:/root:/system/bin/sh" > /etc/passwd" 
adb.exe push ../startnix-s7 /system/bin/startnix-s7
adb.exe shell "chmod 4755 /system/bin/startnix-s7"
# Lets go back to read only.
echo Remounting the filesystem as Read-Only
adb.exe shell "mount -o ro,remount -t ext3 /dev/block/mmcblk1p1 /system"
echo You should now be rooted my friend. Enjoy!

