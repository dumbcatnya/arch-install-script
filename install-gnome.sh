#!bin/sh
pacman -S xorg-server xorg-apps
echo "pick gpu"
echo "1) nvidia"
echo "2) amd"
echo "3) intel"
read gpudriver
if  [$gpudriver == 1]; then 
    pacman -S nvidia nvidia-utils
elif [$gpudriver == 2]; then
    pacman -S xf86-video-ati
elif [$gpudriver == 3]; then
    pacman -S xf86-video-intel
else echo "type valid number" exit
pacman -S gnome gnome-extra networkmanager
systemctl enable gdm 
systemctl enable NetworkManager 
useradd -m -G whell '$username'
echo "type user password:"
passwd '$username'

echo "root ALL=(ALL:ALL) ALL" > /etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "end of script"
echo "reboot into arch"
read -n 1 -r -s -p $'press enter to continue...\n'
reboot
#end of script
