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
base-files ncurses coreutils findutils libgcc
dash bash gzip file sed gawk less util-linux tar
shadow procps-ng tzdata pciutils usbutils iana-etc dhcpcd
kbd iproute2 xbps opendoas kmod eudev runit-void efibootmgr
glibc-locales linux seatd nano
---------------------------------------------------
mount -R /sys /mnt/sys && mount --make-rslave /mnt/sys
mount -R /dev /mnt/dev && mount --make-rslave /mnt/dev
mount -R /proc /mnt/proc && mount --make-rslave /mnt/proc
cp /etc/resolv.conf /mnt/etc/
PS1='(chroot) # ' chroot /mnt/ /bin/bash

echo "void" > /etc/hostname
echo "en_US.UTF-8 UTF-8" > /etc/default/libc-locales
xbps-reconfigure -f glibc-locales
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

nano /etc/vconsole.conf
# KEYMAP=trq

nano /etc/xbps.d/0.conf
# ignorepkg = linux-firmware-{amd,broadcom,nvidia}

nano /etc/default/efibootmgr-kernel-hook
# MODIFY_EFI_ENTRIES=1
# OPTIONS="root=UUID={UID} loglevel=0 console=tty1 udev.log_level=0 vt.global_cursor_default=0 mitigations=off nowatchdog msr.allow_writes=on pcie_aspm=off intel_idle.max_cstate=1 cryptomgr.notests initcall_debug intel_iommu=igfx_off no_timer_check noreplace-smp page_alloc.shuffle=1 rcupdate.rcu_expedited=1 tsc=reliable rootfstype=ext4"
# DISK="/dev/sda"
# PART=1

echo "permit persist :cennedy" > /etc/doas.conf
useradd -m cennnedy
usermod -aG disk,storage,input,audio,video,_seatd cennedy
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
xi make gcc wlroots-devel

# Wayland
xi wlroots foot dmenu-wayland grim slurp wl-clipboard wlsunset

# GPU
xi mesa-dri mesa-vulkan-intel libva-intel-driver

# Sound
xi alsa-utils

# My Programs
xi htop mpv firefox vscode
