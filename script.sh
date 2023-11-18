#! /bin/bash
clear
echo "

                                                       Welcome to ALf's Arch Linux XFCE RU Install Script!
"
sleep 5

loadkeys ru
setfont cyr-sun16
timedatectl set-ntp true

sleep 5
clear

echo "
                                                                    
                                                                    Сделай разметку диска!
"
echo "SDA1 /boot, SDA2 /root, SDA3 SWAP, SDA4 /home"

sleep 5
clear

cfdisk -z /dev/sda

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

pacstrap -K /mnt base base-devel linux linux-firmware nano dhcpcd xorg xorg-server nvidia nvidia-utils nvidia-settings xfce4 mousepad thunar-archive-plugin thunar-media-tags-plugin xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-dict xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin gvfs networkmanager network-manager-applet pipewire pipewire-media-session pipewire-pulse pavucontrol bluez bluez-utils blueman lightdm lightdm-gtk-greeter vivaldi vivaldi-ffmpeg-codecs dosfstools ntfs-3g file-roller p7zip unrar git vlc qbittorrent telegram-desktop shotwell gparted xdg-user-dirs intel-ucode --noconfirm 

sleep 3
genfstab -L /mnt >> /mnt/etc/fstab
sleep 3
echo "

                                                                Настройка fstab
"
sleep 3
arch-chroot /mnt /bin/bash -c "sed -i s/'rw,relatime'/'rw,relatime,discard'/g /etc/fstab"
arch-chroot /mnt /bin/bash -c "sed -i s/'defaults'/'defaults,discard'/g /etc/fstab"

sleep 3
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Asia/Omsk /etc/localtime"

sleep 3
arch-chroot /mnt /bin/bash -c "hwclock --systohc"

arch-chroot /mnt /bin/bash -c "sed -i s/'#en_US.UTF-8'/' en_US.UTF-8'/g /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "sed -i s/'#ru_RU.UTF-8'/' ru_RU.UTF-8'/g /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "locale-gen"
sleep 3
arch-chroot /mnt /bin/bash -c "echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf"
arch-chroot /mnt /bin/bash -c "echo 'KEYMAP=ru' > /etc/vconsole.conf"
arch-chroot /mnt /bin/bash -c "echo 'FONT=cyr-sun16' >> /etc/vconsole.conf"
arch-chroot /mnt /bin/bash -c "echo 'rock' > /etc/hostname"
arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 localhost' > /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '::1       localhost' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 rock.localdomain rock' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "sed -i s/'# %wheel ALL=(ALL:ALL) ALL'/' %wheel ALL=(ALL:ALL) ALL'/g /etc/sudoers"
arch-chroot /mnt /bin/bash -c "mkinitcpio -P"
sleep 3
clear
echo "
                                                        
                                                                Добавляем пользователя alf
"
sleep 5
arch-chroot /mnt /bin/bash -c "useradd -m -G wheel -s /bin/bash alf"
sleep 5

echo "

                                                                     Запускаем СЛУЖБЫ
"
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager"

sleep 2

arch-chroot /mnt /bin/bash -c "systemctl enable lightdm"

sleep 2
arch-chroot /mnt /bin/bash -c "systemctl enable bluetooth"
sleep 2
clear

echo "

                                                              Устанавливаем загрузчик systemd-boot
"
sleep 3
arch-chroot /mnt /bin/bash -c "bootctl install"
sleep 3

echo "

                                                                    Настраиваем loader.conf
"
sleep 3
arch-chroot /mnt /bin/bash -c "echo 'default arch.conf' > /boot/loader/loader.conf"
arch-chroot /mnt /bin/bash -c "echo 'timeout 0' >> /boot/loader/loader.conf"
arch-chroot /mnt /bin/bash -c "echo 'console-mode max' >> /boot/loader/loader.conf"
arch-chroot /mnt /bin/bash -c "echo 'editor no' >> /boot/loader/loader.conf"

echo "

                                                                     Настраиваем arch.conf
"
sleep 3
arch-chroot /mnt /bin/bash -c "echo 'title   Arch Linux' > /boot/loader/entries/arch.conf"
arch-chroot /mnt /bin/bash -c "echo 'linux   /vmlinuz-linux' >> /boot/loader/entries/arch.conf"
arch-chroot /mnt /bin/bash -c "echo 'initrd  /intel-ucode.img' >> /boot/loader/entries/arch.conf"
arch-chroot /mnt /bin/bash -c "echo 'initrd  /initramfs-linux.img' >> /boot/loader/entries/arch.conf"
arch-chroot /mnt /bin/bash -c "echo 'options root="LABEL=arch" rw' >> /boot/loader/entries/arch.conf"

echo "

                                                   НЕ ЗАБЫВАЕМ поставить пароль ROOT зайдя в arch-chroot /mnt
"
sleep 3
echo "

                                                                ПАРОЛЬ СТАВИТСЯ КОМАНДОЙ passwd
"
sleep 3
echo "

                                                        НЕ ЗАБЫВАЕМ поставить пароль от ПОЛЬЗОВАТЕЛЯ alf
"
sleep 3
echo "

                                                                ПАРОЛЬ СТАВИТСЯ КОМАНДОЙ passwd alf
"
sleep 5


echo "

                                                                И НЕ ЗАБУДЬ ПРО MULTILIB /ETC/PACMAN.CONF
"
sleep 5
