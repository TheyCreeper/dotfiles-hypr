# loads gnome

dconf load /org/gnome/ < interface.dconf || true
dconf load /org/gnome/shell/ < shell.dconf || true
dconf load /org/gnome/shell/extensions/ < extensions-settings.dconf || true
