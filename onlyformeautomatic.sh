# Loadkeys
loadkeys uk

# Disk partitioning
cfdisk /dev/sda

# Filesystem creation
mkfs.vfat /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

# Mounting
mount /dev/sda3 /mnt/
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi/
read WAITING

REPO=https://https://repo-default.voidlinux.org/current
ARCH=x86_64

# Copying Keys
mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/

# XBPS-install
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system vim

# Entering chroot
for dir in dev proc sys run; do mount --rbind /$dir /mnt/$dir; mount --make-rslave /mnt/$dir; done
cp /etc/resolv.conf /mnt/etc/
echo -e "127.0.0.1      localhost\n::1      localhost\n127.0.1.1      void.localdomain void" >> /etc/hosts
xchroot /mnt /bin/bash

# Hostname
echo "Enter hostname: "
read HOSTNAME

echo $HOSTNAME > /etc/hostname

# Locales
vim /etc/rc.conf
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
vim /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

# Users
echo "Enter root password: "
passwd

useradd patrick
echo "Enter password for user"
passwd patrick
usermod -aG wheel,floppy,audio,video,cdrom,optical,network,kvm,xbuilder patrick
chsh -s /bin/bash root
xbps-install -S vim
EDITOR=vim visudo

# Repos
xbps-install -S

# Configure fstab
EFI_UUID=$(blkid -s UUID -o value /dev/sda1)
ROOT_UUID=$(blkid -s UUID -o value /dev/sda3)
SWAP_UUID=$(blkid -s UUIS -o value /dev/sda2)

echo "UUID=$ROOT_UUID / ext4 defaults 0 1\nUUID=$SWAP_UUID none swap defaults 0 0\nUUID=$EFI_UUID /boot/efi vfat defaults 0 2\ntmpfs /tmp tmpfs defaults,nosuid,nodev 0 0"

# Grub
xbps-install grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"

# Finalisation
xbps-reconfigure -fa
exit
umount -R /mnt
reboot
