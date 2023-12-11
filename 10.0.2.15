# arch install script

# format partitions
mkfs.ext4 /dev/sda3
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2

# mount partitions
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2

# install packages
pacstrap /mnt base linux linux-firmware base-devel grub efibootmgr networkmanager gnome gnome-tweaks alacritty git vim zsh starship tmux

# generate filesystem table
genfstab /mnt > /mnt/etc/fstab

# -- config in new root --

# timezone
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
arch-chroot /mnt hwclock --systohc

# local
arch-chroot /mnt echo "en_US.UTF-8 UTF-8" > /etc/locale.gen 
locale-gen
arch-chroot /mnt echo "LANG=en_US.UTF-8" > /etc/locale.conf 

# keyboard layout
arch-chroot /mnt echo "KEYMAP=de" > /etc/vconsole.conf 

# hostname
arch-chroot /mnt echo "arch" > /etc/hostname 

# root passwd
arch-chroot /mnt echo "root:1234" | chpasswd --crypt-method SHA256 

# add user
arch-chroot /mnt useradd -m -G wheel -s /bin/zsh vincent
arch-chroot /mnt echo "vincent:1234" | chpasswd --crypt-method SHA256 

# set sudoerfile -> allow group wheel to use sudo
arch-chroot /mnt echo "%wheel ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo) 

# enable services
arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt systemctl enable gdm

# grub
arch-chroot /mnt grub-install /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# -----------------------

# copy the config
cp ./.zshrc /mnt/home/vincent/.zshrc
cp ./.vimrc /mnt/home/vincent/.vimrc
cp -r ./.config /mnt/home/vincent/.config

# umount every unused disk
umount -a

# shutdown
shutdown -h now
