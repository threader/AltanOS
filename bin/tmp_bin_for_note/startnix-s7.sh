#!/system/bin/sh
if [ -e /mnt/sdcard/arm-linux/linux/bin/bash ]; then
echo "Already mounted."
else
busybox insmod /mnt/sdcard/arm-linux/s7/modules/jbd.ko
busybox insmod /mnt/sdcard/arm-linux/s7/modules/ext3.ko
#busybox insmod /mnt/sdcard/arm-linux/s7/modules/jbd2.ko
#busybox insmod /mnt/sdcard/arm-linux/s7/modules/ext4.ko

	if [ -b /dev/block/loop255 ]; then 
	 busybox losetup /dev/block/loop255 /mnt/sdcard/arm-linux/arm-linux.img
	else
	 mknod /dev/block/loop255 b 7 255
	 busybox losetup /dev/block/loop255 /mnt/sdcard/arm-linux/arm-linux.img
	fi

	if [ -d /mnt/sdcard/arm-linux/linux ]; then 
	 mount -o noatime -t ext3 /dev/block/loop255 /mnt/sdcard/arm-linux//linux 
	else
	 mkdir /mnt/sdcard/arm-linux/linux
	 mount -o noatime -t ext3 /dev/block/loop255 /mnt/sdcard/arm-linux/linux
	fi
	
	if [ -e /mnt/sdcard/arm-linux/linux/dev/msm_pcm_out ]; then 
	 echo ""
	else

		if [ -e /dev/msm_pcm_out ]; then 
		busybox cp -r /dev /mnt/sdcard/arm-linux/linux/
		fi

	fi

#busybox mount -o rbind / /mnt/sdcard/arm-linux/linux/media/android-sys/
fi 
export bin=/mnt/sdcard/arm-linux/linux/bin/ 
export PATH=$bin:/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$PATH 
export TERM=linux 
export HOME=/root 
export SHELL=/bin/bash 

setprop ctl.stop media & setprop ctl.stop zygote & busybox chroot /mnt/sdcard/arm-linux/linux/ /bin/bash # && setprop ctl.start media & setprop ctl.start zygote
