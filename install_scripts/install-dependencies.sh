#!/bin/bash

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Arch Linux Dotfiles Installer      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Please do not run this script as root!${NC}"
  exit 1
fi

# Function to install packages
install_packages() {
  echo -e "${YELLOW}Installing required packages...${NC}"
  
  # Core packages
  PACKAGES=(
    "hyprland" 
    "waybar" 
    "kitty" 
    "fish" 
    "starship" 
    "neovim" 
    "rofi" 
    "nwg-drawer"
    "wlogout" 
    "stow"
    "git"
    "xdg-utils"
    "polkit-gnome"
    "pipewire"
    "wireplumber"
    "swww"
    "grim"
    "slurp"
    "swappy"
    "cliphist"
    "wl-clipboard"
    "imagemagick"
    "nautilus"
    "brave-browser"
  )
  
  # Check if yay is installed, if not install it
  if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Installing yay AUR helper...${NC}"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
  fi
  
  # Install packages
  echo -e "${YELLOW}Installing packages with pacman/yay...${NC}"
  yay -S --needed --noconfirm "${PACKAGES[@]}"
  
  # Install hyprlock if not available in repos
  if ! pacman -Qs hyprlock > /dev/null; then
    echo -e "${YELLOW}Installing hyprlock from source...${NC}"
    git clone https://github.com/hyprwm/hyprlock.git /tmp/hyprlock
    cd /tmp/hyprlock
    make && sudo make install
    cd -
    rm -rf /tmp/hyprlock
  fi
  
  echo -e "${GREEN}All packages installed successfully!${NC}"
}

# Function to deploy configurations using stow
deploy_configs() {
  echo -e "${YELLOW}Deploying configurations...${NC}"
  
  # Create backup of existing configs
  BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  
  # List of directories to stow
  CONFIGS=(
    "custom-scripts"
    "fish"
    "hypr"
    "hyprlock"
    "kitty"
    "nvim"
    "rofi"
    "starship"
    "waybar"
    "wlogout"
  )
  
  # Backup existing configs and deploy new ones
  for config in "${CONFIGS[@]}"; do
    if [ -d "$HOME/.config/$config" ]; then
      echo -e "${YELLOW}Backing up existing $config configuration...${NC}"
      cp -r "$HOME/.config/$config" "$BACKUP_DIR/"
      rm -rf "$HOME/.config/$config"
    fi
    
    echo -e "${YELLOW}Deploying $config configuration...${NC}"
    mkdir -p "$HOME/.config"
    stow -t "$HOME/.config" "$config"
  done
  
  echo -e "${GREEN}All configurations deployed successfully!${NC}"
  echo -e "${BLUE}Backup of previous configurations saved to: $BACKUP_DIR${NC}"
}

# Function to create necessary directories
create_directories() {
  echo -e "${YELLOW}Creating necessary directories...${NC}"
  
  # Create background directories
  mkdir -p "$HOME/.config/background/current"
  
  echo -e "${GREEN}Directories created successfully!${NC}"
}

# Main installation process
main() {
  echo -e "${YELLOW}Starting installation process...${NC}"
  
  # Install required packages
  install_packages
  
  # Create necessary directories
  create_directories
  
  # Deploy configurations
  deploy_configs
  
  # Set fish as default shell
  if [ "$SHELL" != "$(which fish)" ]; then
    echo -e "${YELLOW}Setting fish as default shell...${NC}"
    chsh -s "$(which fish)"
  fi
  
  echo -e "${GREEN}Installation completed successfully!${NC}"
  echo -e "${YELLOW}Please log out and log back in to apply all changes.${NC}"
  echo -e "${YELLOW}You may need to reboot to ensure all components work properly.${NC}"
}

# Run the main function
main