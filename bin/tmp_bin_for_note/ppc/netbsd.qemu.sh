

/usr/bin/qemu-system-ppc -monitor stdio -M mac99 -enable-kvm -m 512 -localtime -drive file="/home/mike/NetBSD-7.0.2-macppc.iso",if=ide,index=2,media=cdrom -drive file="/dev/sda8",if=ide,index=0,media=disk -drive file="/dev/sda9",if=ide,index=1,media=disk -boot once=c,menu=on -net none -name "netbsd"


