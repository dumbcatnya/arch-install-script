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

pacstrap /mnt base linux linux-firmware sudo nano
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

cat /usr/share/zoneinfo/
echo "select zone"
read zone

cat /usr/share/zoneinfo/$zone
echo "select subzone"
read subzone

ln -sf /usr/share/zoneinfo/$zone/$subzone /etc/localtime

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" > /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo '$hostname' > /etc/hostname
echo "127.0.1.1" '$hostname' >> /etc/hosts

echo "set password for root"
passwd 

pacman -S grub efibootmgr os-prober mtools
mkdir /boot/efi
mount /dev/'$bootpartition' /boot/efi
grub-install --target=x86_64-efi --bootloader-id=grub_uefi
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S git wget
wget https://raw.githubusercontent.com/rushia272/arch-install-script/main/install-gnome.sh
sh install-gnome.sh
#end of script