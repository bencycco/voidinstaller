xbps-install xdg-utils rtkit xdg-desktop-portal xdg-user-dirs

xdg-user-dirs-update
ln -s /etc/sv/rtkit /var/service
echo "Enter (under new line): "QT_QPA_PLATFORM=wayland-egl""
echo "and also "SDL_VIDEODRIVER=wayland""
echo "and also "MOZ_ENABLE_WAYLAND=1""
echo "and also "ELM_DISPLAY=wl""
