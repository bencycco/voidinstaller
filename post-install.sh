echo "Choose DE (1) or WM (2)"
read WMDE
if [ $WMDE = "1" ]
then
        echo "Choose your WM"
        echo "1) GNOME"
        echo "2) XFCE"
        echo "3) KDE5"
        echo "4) Cinnamon"
        read DE

        if [ $DE = "1" ]
        then
                xbps-install curl wget xz unzip zip vim gptfdisk xtools mtools mlocate ntfs-3g fuse-exfat bash-completion linux-headers gtksourceview4 ffmpeg mesa-vdpau mesa-vaapi htop
                xbps-install xorg gnome gdm
                ln -s /etc/sv/gdm /var/service
                xbps-install -Rs xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-util
                xbps-install -y dbus elogind
                ln -s /etc/sv/dbus /var/service
                ln -s /etc/sv/elogind /var/service
                xbps-install NetworkManager NetworkManager-openvpn NetworkManager-openconnect NetworkManager-vpnc NetworkManager-l2tp
                ln -s /etc/sv/NetworkManager /var/service
                xbps-install pulseaudio pulseaudio-utils pulsemixer alsa-plugins-pulseaudio

                xbps-install tilix firefox
        elif [ $DE = "2" ]
        then
                xbps-install pulseaudio dbus xfce4 xorg-minimal xorg-fonts mesa-dri lightdm lightdm-gtk-greeter xfce4-terminal xfce4-plugins NetworkManager network-manager-applet
                ln -s /etc/sv/dbus /var/service
                ln -s /etc/sv/NetworkManager /var/service
                ln -s /etc/sv/dbus /var/service
                ln -s /etc/sv/lightdm /var/service
        elif [ $DE = "3" ]
        then
                xbps-install -y kde5 kde5-baseapps xorg elogind dbus pulseaudio alsa-plugins-pulseaudio cronie bluez xdg-desktop-portal kdegraphics-thumbnailers chrony libavdevice libavcodec xorg-server-xwayland ffmpegthumbs xdg-desktop-portal-kde sddm firefox flatpak konsole
                xbps-install -y kde5-baseapps
                ln -s /etc/sv/dbus /var/service/
                ln -s /etc/sv/elogind /var/service/
                ln -s /etc/sv/bluetoothd /var/service/
                ln -s /etc/sv/cronie /var/service/
                ln -s /etc/sv/chronyd /var/service/
                ln -s /etc/sv/sddm /var/service/
        elif [ $DE = "4" ]
        then
                
