# Backs up gnome config
set -e
dconf dump /org/gnome/ > interface.dconf
dconf dump /org/gnome/shell/ > shell.dconf
dconf dump /org/gnome/shell/extensions/ > extensions-settings.dconf