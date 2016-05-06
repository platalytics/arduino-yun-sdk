# copy this memory expansion in your Arduino Yun device
# set permissions 
# chmod +x /root/memory-expansion.sh
# and run it
# /root/memory-expansion.sh
#
# simplesd.sh from internet https://www.dropbox.com/s/jl4oytptxrb6q5u/simplesd.sh
# credits to whoever extracted this command sequence from YunDiskSpaceExpander.ino

opkg update
opkg install e2fsprogs fdisk

if fdisk -l |grep /dev/sda > /dev/null; then
    echo "Start"
else
    echo "/dev/sda not found!"
    exit 0
fi

dd if=/dev/zero of=/dev/sda bs=4096 count=10
(echo n; echo p; echo 1;  echo;  echo; echo w)  | fdisk /dev/sda

umount -f  /mnt/sda1

mkfs.ext4 /dev/sda1

mkdir -p /mnt/sda1
mount  /dev/sda1 /mnt/sda1
mkdir -p /tmp/cproot
mount --bind / /tmp/cproot
tar -C /tmp/cproot -cvf - . | tar -C /mnt/sda1 -xf -
umount /tmp/cproot

uci add fstab mount
uci set fstab.@mount[0].target=/
uci set fstab.@mount[0].device=/dev/sda1
uci set fstab.@mount[0].fstype=ext4
uci set fstab.@mount[0].enabled=1
uci set fstab.@mount[0].enabled_fsck=0
uci set fstab.@mount[0].options=rw,sync,noatime,nodiratime
uci commit

reboot