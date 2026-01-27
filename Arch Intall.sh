# Install wanted arch packages
sudo pacman -Syu --needed - < arch_pkgslist.txt

# Install gnome settings
./dot_config/gnome/install.sh

