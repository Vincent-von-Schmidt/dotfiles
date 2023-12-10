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
pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr vim networkmanager plasma sddm terminator

# generate filesystem
genfstab /mnt > /mnt/etc/fstab

# -- config in new root --

# change root
arch-chroot /mnt

# timezone
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# local -> TODO
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf 

# keyboard layout
echo "KEYMAP=de" > /etc/vconsole.conf 

# hostname
echo "arch" > /etc/hostname 

# root passwd
echo "root:1234" | chpasswd --crypt-method SHA256 

# add user
useradd -m -G wheel -s /bin/bash vincent
echo "vincent:1234" | chpasswd --crypt-method SHA256 

# set sudoerfile -> allow group wheel to use sudo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo) 

# enable services
systemctl enable NetworkManager
systemctl enable sddm

# grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# logout of system and go back the usb env
exit

# -----------------------

# umount every unused disk
umount -a

# shutdown
shutdown -h now
