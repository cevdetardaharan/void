# fdisk
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

# mount
mount /dev/sda2 /mnt/
mkdir /mnt/boot/
mount /dev/sda1 /mnt/boot/

# repo
REPO=https://voidlinux.mirror.garr.it/current/musl

# PC architecture
ARCH=x86_64-musl

# base-installation
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO"
---------------------------------------------------
musl base-files ncurses coreutils findutils diffutils
libgcc dash bash grep gzip file sed gawk less util-linux
tar shadow e2fsprogs dosfstools procps-ng tzdata usbutils
iana-etc dhcpcd kbd iproute2 xbps opendoas kmod eudev runit-void
linux efibootmgr seatd nano
---------------------------------------------------
mount -R /sys /mnt/sys && mount --make-rslave /mnt/sys
mount -R /dev /mnt/dev && mount --make-rslave /mnt/dev
mount -R /proc /mnt/proc && mount --make-rslave /mnt/proc
cp /etc/resolv.conf /mnt/etc/
PS1='(chroot) # ' chroot /mnt/ /bin/bash

echo "void" > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

nano /etc/xbps.d/0.conf
# ignorepkg = linux-firmware-{amd,broadcom,nvidia}

nano /etc/default/efibootmgr-kernel-hook
# MODIFY_EFI_ENTRIES=1
# OPTIONS="root=UUID={UID} rootfstype=ext4 loglevel=0 console=tty1 udev.log_level=0 vt.global_cursor_default=0 nordrand nowatchdog initcall_debug tsc=reliable random.trust_cpu=0"
# DISK="/dev/sda"
# PART=1

echo "permit persist :cennedy" > /etc/doas.conf
useradd -m cennnedy
usermod -aG audio,video,_seatd cennedy
passwd cennedy
passwd

cp /proc/mounts /etc/fstab
blkid >> /etc/fstab
# tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
# UUID={UID} / ext4 rw,relatime 0 1
# UUID={UID} /boot vfat rw,relatime 0 2
xbps-reconfigure -fa
exit
umount -R /mnt/
reboot now

# DWL build
xi make gcc pkgconf wlroots-devel git
git clone https://github.com/cevdetardaharan/dwl

# Wayland
xi wlroots foot dmenu-wayland grim slurp wl-clipboard wlsunset

# Fonts
xi font-hack-ttf

# GPU
xi mesa-dri libva-intel-driver

# Sound
xi alsa-utils

# My Programs
xi htop mpv firefox yt-dlp spotifyd spotify-tui
