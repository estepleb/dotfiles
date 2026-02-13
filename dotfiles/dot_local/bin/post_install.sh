#!/usr/env/bin bash

echo "------------------- paru installation -------------------"

# Check if paru is installed
if command -v paru >/dev/null 2>&1; then
  echo "paru is already installed."
else
  echo "paru not found. Installing..."
  mkdir -p "$HOME/programs"
  cd "$HOME/programs" || exit

  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd "paru" || exit
  makepkg -si

  echo "paru installed successfully!"
fi

echo "------------------- pacman packages -------------------"
# Install packages
sudo pacman -S --needed --noconfirm - < pkglist.txt


fi
echo "------------------- AUR packages -------------------"
# Install AUR packages
paru -S --needed --noconfirm - < aurlist.txt
echo "AUR packages installed successfully!"

# Install flatpak packages
flatpak install --noninteractive < flatpaks.txt

echo "------------------- flatpak packages -------------------"
# Flatpak settings
flatpak override --user \
  --filesystem=xdg-config/gtk-2.0:ro \
  --filesystem=xdg-config/gtk-3.0:ro \
  --filesystem=xdg-config/gtk-4.0:ro \
  --filesystem=~/.gtkrc-2.0:ro

flatpak override --user \
  --filesystem=xdg-config/qt5ct:ro \
  --filesystem=xdg-config/qt6ct:ro \
  --env=QT_QPA_PLATFORMTHEME=qt6ct

echo "flatpak packages installed successfully!"

# Hyprpm 

hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/sandwichfarm/hyprexpo-plushyprpm 
hyprpm enable hyprexpo-plus
hyprpm enable hyprscrolling
hyprpm reload

echo "hyprpm packages installed successfully!"


echo "------------------- dotfiles -------------------"
git clone --recurse-submodules https://github.com/estepleb/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles" || exit

# waytrogen 

echo "dotfiles installed successfully!"

echo "------------------- settings -------------------"
gsettings set org.gnome.desktop.default-applications.terminal exec 'foot'


echo "services enabled and started!"

echo "------------------- fish configurations -------------------"

chsh -s "$(which fish)"
fish_update_completions

echo "fish configured successfully!"
