#!bin/sh
ls /usr/share/zoneinfo
echo "select zone"
read zone

ls /usr/share/zoneinfo/$zone
echo "select subzone"
read subzone

ln -sf /usr/share/zoneinfo/$zone/$subzone /etc/localtime

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" > /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo "type hostname:"
read hostname
echo $hostname > /etc/hostname
echo "127.0.1.1" $hostname >> /etc/hosts

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
