#!bin/sh
if nc -zw1 google.com 443; then
  echo "connected to internet"
    else echo "connect to internet first" exit
fi
echo "Type hostname:"
read hostname
export hostname
echo "Type user name:"
read username
export username

fdisk -l
echo "select drive for arch install"
read drivename
echo "format your drive"
read -n 1 -r -s -p $'press enter to continue...\n'
cfdisk /dev/$drivename

echo "Select root partition"
read rootpartition
mkfs.ext4 /dev/$rootpartition

echo "Select boot partition"
read bootpartition
mkfs.fat -F 32 /dev/$bootpartition
export bootpartition

echo "Select swap partition"
read swappartition
mkswap /dev/$swappartition
swapon /dev/$swappartition

pacman -Syy
mount /dev/$rootpartition /mnt

cd /mnt
rm run-in-chroot.sh
wget https://raw.githubusercontent.com/rushia272/arch-install-script/main/run-in-chroot.sh
cd
pacstrap /mnt base linux linux-firmware sudo nano
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash run-in-chroot.sh
#end of script
