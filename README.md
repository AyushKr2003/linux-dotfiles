# Dotfiles for Garuda Linux Hyprland

This repository contains my personal dotfiles for configuring and customizing my Garuda Linux system running the [Hyprland](https://github.com/hyprwm/Hyprland) Wayland compositor. These configuration files are managed using [GNU Stow](https://www.gnu.org/software/stow/) for easy deployment and modular organization.

## Features

- Dotfiles designed specifically for **Garuda Linux** with **Hyprland**.
- Configuration for:
  - **Hyprland** (Wayland compositor)
  - **Waybar** (status bar)
  - **alacritty** (terminal emulator)
  - **wpaperd** (background image manager)
  - **neovim** (text editor)
  - **fish** (shell)
  - **zathura** (PDF viewer)
  - **ranger** (file manager)
  - **dunst** (notification daemon)
  - **polybar** (optional, alternative status bar)
  - And more...
- Modular management with **GNU Stow** for simplicity and flexibility.

## Prerequisites

1. Ensure **GNU Stow** is installed.  
   Install it using your package manager:
   ```bash
   sudo pacman -S stow
   ```

2. Install the necessary dependencies for each application. You can find specific instructions in each module's README or inside the respective config directories.

   Example for **Hyprland** and **Waybar**:
   ```bash
   sudo pacman -S hyprland waybar
   ```

## Installation

### Clone the repository

Clone this repository to your system:
```bash
git clone https://github.com/your-username/garuda-hyprland-dotfiles.git
cd garuda-hyprland-dotfiles
```

### Stow the configurations

To deploy the dotfiles, you can use **GNU Stow**. For example, to set up the configurations for **Hyprland**, run:

```bash
stow hyprland
```

This will create symlinks to the correct locations. You can do this for all available configurations like so:

```bash
stow hyprland
stow waybar
stow alacritty
stow neovim
stow fish
stow wpaperd
# Add other stow commands for additional configurations
```

### Set up your environment

After stowing the configurations, you can apply any necessary environment settings.

1. **Wayland/Hyprland**: Ensure you're running the system under a Wayland session with **Hyprland**.
2. **Terminal Emulator**: If you use **Alacritty**, set it as your default terminal:
   ```bash
   sudo update-alternatives --config x-terminal-emulator
   ```
3. **Neovim**: Install **Neovim** and any required plugins. You can use [vim-plug](https://github.com/junegunn/vim-plug) or any other plugin manager for this.

### Set the wallpaper

You can set your wallpaper with **wpaperd**. If it's included in your setup, run:

```bash
wpaperd --config ~/.config/wpappd/config.toml
```

Ensure that your wallpaper directory and configuration are correctly set up.

## Customization

You can customize your system further by modifying the configuration files for each application. The dotfiles are modular, so you can easily modify or remove any specific application without affecting others.

For example, to modify the **Waybar** configuration:

```bash
stow waybar
# Edit ~/.config/waybar/config to your preferences
```

Similarly, you can edit the **neovim** or **fish** configurations by navigating to their respective configuration files under `~/.config/neovim` or `~/.config/fish`.

## Contributing

Feel free to fork this repository and create a pull request if you'd like to contribute or improve upon the configurations.

## License

This repository is licensed under the MIT License.
