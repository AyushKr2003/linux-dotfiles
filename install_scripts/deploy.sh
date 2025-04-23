#!/bin/bash

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Arch Linux Dotfiles Deployment     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo -e "${RED}GNU Stow is not installed. Please install it first.${NC}"
  echo -e "${YELLOW}Run: sudo pacman -S stow${NC}"
  exit 1
fi

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

# Function to deploy configurations
deploy_configs() {
  echo -e "${YELLOW}Deploying configurations...${NC}"
  
  # Create backup of existing configs
  BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  
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

# Main function
main() {
  echo -e "${YELLOW}Starting deployment process...${NC}"
  
  # Create necessary directories
  create_directories
  
  # Deploy configurations
  deploy_configs
  
  echo -e "${GREEN}Deployment completed successfully!${NC}"
  echo -e "${YELLOW}You may need to restart your Hyprland session to apply all changes.${NC}"
}

# Run the main function
main