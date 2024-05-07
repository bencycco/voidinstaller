xbps-install -u xbps
xbps-install -Syu
xbps-intall xorg dbus dbus-elogind polkit-elogin mc
xbps-install NetworkManager
xbps-install open-vm-tools

# Enable services
ln -s /etc/sv/NetworkManager /var/service
ln -s /etc/sv/dbus /var/service
ln -s /etc/sv/polkitd /var/service
ln -s /etc/sv/vm* /var/service

xbps-install mesa-dri mesa-vmwgfx-dri
xbps-install xf86-video-vmware xorg-fonts
xbps-install wayland wlroots sway dmenu dmenu-wayland rxvt-unicode foot firefox konsole

echo "vmwgfx cursor broken my default."
echo "Input: "WLR_NO_HARDWARE_CURSORS=1", to /etc/environment"
echo "Press any key and then enter to continue."
vim /etc/environment
echo "Now enter: "dbus-launch sway" to launch sway (after reboot)"

reboot
