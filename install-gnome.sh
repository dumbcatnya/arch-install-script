#!bin/sh
pacman -S xorg-server xorg-apps
pacman -S nvidia nvidia-utils xf86-video-ati xf86-video-intel   
pacman -S gnome gnome-extra networkmanager
systemctl enable gdm 
systemctl enable NetworkManager 
echo "type username:"
read username
useradd -m -G wheel $username
echo "type user password:"
passwd $username

echo "root ALL=(ALL:ALL) ALL" > /etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "end of script"
echo "reboot into arch"
read -n 1 -r -s -p $'press enter to continue...\n'
reboot
#end of script
