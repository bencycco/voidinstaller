import os
import sys
import time

print("Time to Enter the Void...")
print("This process only runs on UEFI boots WITH sudo/root permissions.")
time.sleep(0.2)
print("WARNING: This script WILL result in the loss of data.\nIf you are suspicious of this program please check through it!\n")
time.sleep(0.2)

# Loading Keyboard
keyboard = input('Enter your keyboard layout: ')
os.system(f'loadkeys {keyboard}')

# Beginning the Partitioning
partition_location = input('Enter your Partition location (? for lsblk): ')

if partition_location == '?':
    os.system('lsblk')
    time.sleep(1)
    partition_location = input('Enter your Partition location: ')

print("Use this as a guide to UEFI partitioning:")
print(f"Boot Partition: 128 to 500M, use {partition_location}1")
time.sleep(0.3)
print("SWAP Partition (optional but recommended):")
print("If your RAM is <2GB use 2x your RAM")
print("If your RAM is 2-8GB, use the same amount as your RAM")
print("If your RAM is 8-64GB or 64GB, use 4GB")
print(f"For SWAP use {partition_location}2")
print(f"And finally, use all of the remaining space for your root partition {partition_location}3")
print("You may want to write this down.")
print("When cfdisk is opened, choose gpt, delete EVERYTHING, partition the drive, and then write it (you must type 'yes' to write to the drive)")
print("When you create the boot partition, edit the type and choose 'EFI System'")
time.sleep(0.2)
wait = input(f'Press any key and then enter to continue to cfdisk the drive')
os.system(f'cfdisk {partition_location}')
print("Partitioning Complete!")
time.sleep(0.2)

# Formatting the disks
print("Making filesystems...")
os.system(f'mkfs.vfat {partition_location}1')
print("Boot partition created.")
os.system(f'mkfs.ext4 {partition_location}3')
print("Root partition created.")
os.system(f'mkswap {partition_location}2')
print("SWAP partition created.")
time.sleep(0.2)

# Mounting Filesystems
print("Mounting Filesystems...")
print("Mounting root partition...")
os.system(f'mount {partition_location}3 /mnt')
print("Mounting boot partition...")
os.system(f'mkdir -p /mnt/boot/efi')
os.system(f'mount {partition_location}1 /mnt/boot/efi')
print("Activating Swap partition...")
os.system(f'swapon {partition_location}2')
print("Done!")
time.sleep(0.1)

# Selecting a Mirror
repo = input('Enter the URL of your prefered mirror: ')
arch = input("""
Choose one of the following numbers:
1) x86_64
2) x86_64-musl
3) i686
4) aarch64
             """)

if arch = "1":
    arch = "x86_64"
elif arch = "2":
    arch = "x86_64-musl"
elif arch = "3":
    arch = "i686"
elif arch = "4":
    arch = "aarch64"

print("Copying RSA Keys...")
os.system('mkdir -p /mnt/var/db/xbps/keys')
os.system('cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/')
print("Installing base system, this may take some time.")
os.system(f'XBPS_ARCH={arch} xbps-install -S -r /mnt "{repo}" base-system')

# Entering Chroot
print("Entering chroot...")
os.system('xchroot /mnt /bin/bash')
print("Updating for safety...")
os.system('xbps-install -Su')
print("Done!")

# Setting configurations
hostname = input('Enter your hostname: ')
os.system(f'echo "{hostname}" >> /etc/hostname')
print('Enter your root password: ')
os.system('passwd')

# Configuring fstab
print("Configuring fstab...")
os.system('cp /proc/mounts /etc/fstab')

