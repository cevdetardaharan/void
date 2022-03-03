# fdisk
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

# mount
mount /dev/sda2 /mnt/
mkdir /mnt/boot/
mount /dev/sda1 /mnt/boot/

# repo
REPO=https://alpha.de.repo.voidlinux.org/current

# PC architecture
ARCH=x86_64

# base-installation
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO"
---------------------------------------------------
base-files ncurses coreutils findutils diffutils libgcc
dash bash grep gzip file sed gawk less util-linux which tar
shadow procps-ng tzdata pciutils usbutils iana-etc dhcpcd
kbd xbps iproute2 xbps opendoas kmod eudev runit-void
---------------------------------------------------
mount -R /sys /mnt/sys && mount --make-rslave /mnt/sys
mount -R /dev /mnt/dev && mount --make-rslave /mnt/dev
mount -R /proc /mnt/proc && mount --make-rslave /mnt/proc
cp /etc/resolv.conf /mnt/etc/
PS1='(chroot) # ' chroot /mnt/ /bin/bash

echo "void" > /etc/hostname

ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

nano /etc/vconsole.conf
# KEYMAP=trq

nano /etc/xbps.d/d.conf
# ignorepkg = linux-firmware-{amd,broadcom,nvidia}

nano /etc/default/efibootmgr-kernel-hook
# MODIFY_EFI_ENTRIES=1
# OPTIONS="root=UUID={UID} loglevel=4"
# DISK="/dev/sda"
# PART=1

echo "permit persist :cennedy" > /etc/doas.conf
useradd -m cennnedy
usermod -aG audio,video cennedy
passwd cennedy
passwd

cp /proc/mounts /etc/fstab
blkid >> /etc/fstab
# efivarfs /sys/firmware/efi/efivars efivarfs defaults 0 0
# UUID={UID} / ext4 rw,relatime 0 1
# UUID={UID} /boot vfat rw,relatime 0 2
xbps-reconfigure -fa
exit
umount -R /mnt/
reboot now


# Build
xi libX11-devel libXft-devel make pkgconf

# XORG
xi dbus-x11 xorg-server sx mesa-dri

# Sound
xi alsa-utils
