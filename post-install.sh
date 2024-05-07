xbps-install -u xbps
xbps-install -Syu
xbps-intall xorg dbus dbus-elogind polkit-elogin mc
xbps-install NetworkManager
xbps-install open-vm-tools

# Enable services
ln -s /etc/sv/NetworkManager /var/service
ln -s /etc/sv/elogind /var/service
ln -s /etc/sv/dbus /var/service
ln -s /etc/sv/polkitd
sv up dbus
sv up elogind
