#! /bin/bash
clear
echo 		"Welcome to ALf's Arch Linux RU Install Script!"


loadkeys ru
setfont cyr-sun16
timedatectl set-ntp true

sleep 5
clear

echo 		"Сделай разметку диска!"
echo " SDA1 /boot, SDA2 /root, SDA3 SWAP, SDA4 /home"

sleep 5
clear

cfdisk -z

mkfs.fat -F 32 /dev/sda1
sleep 3
mkfs.ext4 -L arch /dev/sda2
sleep 3
mkfs.ext4 -L home /dev/sda4
sleep 3
mkswap /dev/sda3

mount /dev/sda2 /mnt
sleep 3
mount --mkdir /dev/sda1 /mnt/boot
sleep 3
mount --mkdir /dev/sda4 /mnt/home
sleep 3
swapon /dev/sda3
sleep 2

lsblk
sleep 5

pacstrap -K /mnt base base-devel linux linux-firmware nano dhcpcd xorg xfce4 xfce4-goodies gvfs networkmanager network-manager-applet pipewire pipewire-media-session pipewire-pulse pavucontrol bluez bluez-utils blueman lightdm lightdm-gtk-greeter vivaldi vivaldi-ffmpeg-codecs --noconfirm 

sleep 3
genfstab -L /mnt >> /mnt/etc/fstab

sleep 3
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Asia/Omsk /etc/localtime"

sleep 3
arch-chroot /mnt /bin/bash -c "hwclock --systohc"

arch-chroot /mnt /bin/bash -c "sed -i s/'#en_US.UTF-8'/'en_US.UTF-8'/g /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "sed -i s/'#ru_RU.UTF-8'/'ru_RU.UTF-8'/g /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "locale-gen"
sleep 3
arch-chroot /mnt /bin/bash -c "echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf"
arch-chroot /mnt /bin/bash -c "echo 'KEYMAP=ru' > /etc/vconsole.conf"
arch-chroot /mnt /bin/bash -c "echo 'FONT=cyr-sun16' >> /etc/vconsole.conf"
arch-chroot /mnt /bin/bash -c "echo 'rock' > /etc/hostname"
arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 localhost' > /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '::1       localhost' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 rock.localdomain rock' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "sed -i s/'# %wheel ALL=(ALL:ALL) ALL'/'%wheel ALL=(ALL:ALL) ALL'/g /etc/sudoers"
arch-chroot /mnt /bin/bash -c "mkinitcpio -P"
sleep 5
echo "root:$password" | arch-chroot /mnt chpasswd

sleep 5
arch-chroot /mnt /bin/bash -c "useradd -m -G wheel -s /bin/bash alf"
echo "alf:$userpassword" | arch-chroot /mnt chpasswd
sleep 5
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager"

sleep 5

arch-chroot /mnt /bin/bash -c "systemctl enable lightdm"

sleep 5
arch-chroot /mnt /bin/bash -c "systemctl enable bluetooth"

sleep 5
arch-chroot /mnt /bin/bash -c "bootctl install"
