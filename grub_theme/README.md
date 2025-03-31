# GRUB Theme - Catppuccin Mocha

A sleek, modern GRUB bootloader theme using the Catppuccin Mocha color palette. This theme enhances your system's boot experience with elegant styling and improved usability.

<!-- ![Theme Preview](preview.png) -->

## Features

- **Catppuccin Mocha Color Scheme**: Utilizes the popular Catppuccin Mocha palette for a cohesive and modern look
- **Clean Interface**: Minimalist design with clear navigation indicators
- **Custom Welcome Screen**: Personalized greeting on boot
- **Progress Bar**: Visual indication of boot timeout
- **Intuitive Controls**: On-screen key bindings for easy navigation

## Installation

Follow these steps to install the Catppuccin Mocha GRUB theme:

### 1. Copy the Theme Files

Copy the theme directory to your GRUB themes folder:

```bash
sudo cp -r my_theme_mocha /boot/grub/themes/
```

### 2. Update GRUB Configuration

Edit your GRUB configuration file:

```bash
sudo nano /etc/default/grub
```

### 3. Set the Theme Path

Add or modify the following line in your GRUB configuration:

```bash
GRUB_THEME="/boot/grub/themes/my_theme_mocha/theme.txt"
```

You may also want to adjust other settings like:

```bash
# Timeout in seconds
GRUB_TIMEOUT=5

# Uncomment to show the menu
GRUB_TIMEOUT_STYLE=menu
```

### 4. Apply Changes

Update your GRUB configuration:

```bash
# For most Linux distributions
sudo update-grub

# For some distributions, use:
# sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 5. Reboot

Restart your system to see the new theme:

```bash
sudo reboot
```

## Customization

The theme can be easily customized to suit your preferences:

### Background Image

Replace `background.png` in the theme folder with your preferred image. For best results, use an image that matches your screen resolution.

### Fonts and Colors

Edit `theme.txt` to change fonts and colors:

- **Fonts**: The theme uses "DejaVu Sans" and "Terminus" fonts. You can modify font types and sizes.
- **Colors**: The theme uses Catppuccin Mocha colors. You can adjust any color code to match your preference.

Example of color customization in `theme.txt`:

```
# Change the welcome text color
color = "#f5c2e7"  # Change to Catppuccin pink
```

### Menu Layout

Adjust the menu position and size by modifying the `boot_menu` section in `theme.txt`.

## Troubleshooting

- **Theme Not Appearing**: Ensure the path in `GRUB_THEME` is correct and that you've run `update-grub` or equivalent.
- **Missing Fonts**: The theme requires DejaVu Sans and Terminus fonts. Install them if they're not available on your system.
- **Broken Layout**: If the layout appears broken, check your screen resolution and adjust the theme accordingly.

## Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin) - Color palette inspiration
- [GRUB2 Theme Reference](https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html) - Official documentation

## License

This theme is licensed under the [MIT License](LICENSE).

---

Created by Ayush Kumar Singh