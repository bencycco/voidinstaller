xbps-install xdg-utils rtkit xdg-desktop-portal xdg-user-dirs

xdg-user-dirs-update
ln -s /etc/sv/rtkit /var/service
echo "Enter (under new line): "QT_QPA_PLATFORM=wayland-egl""
echo "and also "SDL_VIDEODRIVER=wayland""
echo "and also "MOZ_ENABLE_WAYLAND=1""
echo "and also "ELM_DISPLAY=wl""
echo "Press any key and then enter to continue."
read WAITING

xbps-install qt6-wayland qt6-wayland-devel
echo "-----ALL DONE-----"
