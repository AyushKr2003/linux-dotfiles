#!/bin/bash

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Catppuccin Mocha GRUB Installer    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}This script must be run as root!${NC}"
  echo -e "${YELLOW}Please run: sudo $0${NC}"
  exit 1
fi

# Define paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="my_theme_mocha"
THEME_DIR="$SCRIPT_DIR/$THEME_NAME"
GRUB_THEMES_DIR="/boot/grub/themes"
GRUB_CFG_PATH="/boot/grub/grub.cfg"
GRUB_DEFAULT_PATH="/etc/default/grub"

# Function to install the theme
install_theme() {
  echo -e "${YELLOW}Installing GRUB theme...${NC}"
  
  # Create themes directory if it doesn't exist
  mkdir -p "$GRUB_THEMES_DIR"
  
  # Check if theme already exists and backup if needed
  if [ -d "$GRUB_THEMES_DIR/$THEME_NAME" ]; then
    echo -e "${YELLOW}Backing up existing theme...${NC}"
    mv "$GRUB_THEMES_DIR/$THEME_NAME" "$GRUB_THEMES_DIR/${THEME_NAME}.bak.$(date +%Y%m%d-%H%M%S)"
  fi
  
  # Copy theme files
  echo -e "${YELLOW}Copying theme files...${NC}"
  cp -r "$THEME_DIR" "$GRUB_THEMES_DIR/"
  
  # Set permissions
  chmod -R 755 "$GRUB_THEMES_DIR/$THEME_NAME"
  
  echo -e "${GREEN}Theme files installed successfully!${NC}"
}

# Function to update GRUB configuration
update_grub_config() {
  echo -e "${YELLOW}Updating GRUB configuration...${NC}"
  
  # Backup the original grub default file
  cp "$GRUB_DEFAULT_PATH" "${GRUB_DEFAULT_PATH}.bak.$(date +%Y%m%d-%H%M%S)"
  
  # Check if GRUB_THEME is already set
  if grep -q "^GRUB_THEME=" "$GRUB_DEFAULT_PATH"; then
    # Replace existing GRUB_THEME line
    sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$GRUB_THEMES_DIR/$THEME_NAME/theme.txt\"|" "$GRUB_DEFAULT_PATH"
  else
    # Add GRUB_THEME line if it doesn't exist
    echo "GRUB_THEME=\"$GRUB_THEMES_DIR/$THEME_NAME/theme.txt\"" >> "$GRUB_DEFAULT_PATH"
  fi
  
  # Ensure GRUB_TERMINAL_OUTPUT is not set to console
  if grep -q "^GRUB_TERMINAL_OUTPUT=\"console\"" "$GRUB_DEFAULT_PATH"; then
    sed -i "s/^GRUB_TERMINAL_OUTPUT=\"console\"/#GRUB_TERMINAL_OUTPUT=\"console\"/" "$GRUB_DEFAULT_PATH"
  fi
  
  # Set recommended GRUB settings
  if ! grep -q "^GRUB_TIMEOUT=" "$GRUB_DEFAULT_PATH"; then
    echo "GRUB_TIMEOUT=5" >> "$GRUB_DEFAULT_PATH"
  fi
  
  if ! grep -q "^GRUB_TIMEOUT_STYLE=" "$GRUB_DEFAULT_PATH"; then
    echo "GRUB_TIMEOUT_STYLE=menu" >> "$GRUB_DEFAULT_PATH"
  fi
  
  echo -e "${GREEN}GRUB configuration updated successfully!${NC}"
}

# Function to regenerate GRUB configuration
regenerate_grub() {
  echo -e "${YELLOW}Regenerating GRUB configuration...${NC}"
  
  # Detect the appropriate command to update GRUB
  if command -v update-grub &> /dev/null; then
    update-grub
  elif command -v grub-mkconfig &> /dev/null; then
    grub-mkconfig -o "$GRUB_CFG_PATH"
  elif command -v grub2-mkconfig &> /dev/null; then
    grub2-mkconfig -o "$GRUB_CFG_PATH"
  else
    echo -e "${RED}Could not find a command to update GRUB.${NC}"
    echo -e "${YELLOW}Please run one of the following commands manually:${NC}"
    echo -e "${YELLOW}  - update-grub${NC}"
    echo -e "${YELLOW}  - grub-mkconfig -o $GRUB_CFG_PATH${NC}"
    echo -e "${YELLOW}  - grub2-mkconfig -o $GRUB_CFG_PATH${NC}"
    return 1
  fi
  
  echo -e "${GREEN}GRUB configuration regenerated successfully!${NC}"
  return 0
}

# Main installation process
main() {
  echo -e "${YELLOW}Starting GRUB theme installation...${NC}"
  
  # Install theme files
  install_theme
  
  # Update GRUB configuration
  update_grub_config
  
  # Regenerate GRUB
  if regenerate_grub; then
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo -e "${YELLOW}Please reboot your system to see the new GRUB theme.${NC}"
  else
    echo -e "${RED}Installation completed with warnings.${NC}"
    echo -e "${YELLOW}Please update your GRUB configuration manually and reboot.${NC}"
  fi
}

# Run the main function
main