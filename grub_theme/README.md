# GRUB Theme

This is a custom GRUB theme designed to enhance the bootloader interface for your system. It provides a more personalized and visually appealing boot experience by modifying the default GRUB boot menu.

## Features

- Custom background image
- Custom fonts and colors
- Stylish boot menu layout

## Installation

To apply this GRUB theme, follow the instructions below:

### 1. Copy the Theme

First, dcopy the theme files to a suitable directory on your system. For example, you can place them in `/boot/grub/themes/[your-theme-name]`.

```bash
sudo cp -r /path/to/your/my_theme_mocha /boot/grub/themes/
```

### 2. Update GRUB Configuration

Next, open the GRUB configuration file for editing:

```bash
sudo nvim /etc/default/grub
```

### 3. Modify GRUB Configuration

In the `/etc/default/grub` file, set the following variables:

- Set the theme path to your theme directory:

  ```bash
  GRUB_THEME="/boot/grub/themes/my_theme_mocha/theme.txt"
  ```

- Optionally, configure any other GRUB settings to your preference (e.g., `GRUB_TIMEOUT`, `GRUB_HIDDEN_TIMEOUT`).

### 4. Update GRUB

Once you've modified the GRUB configuration, update GRUB to apply the changes:

  ```bash
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ```

### 5. Reboot Your System

Reboot your system to see your custom GRUB theme in action:

```bash
sudo reboot
```

## Customizing the Theme

You can easily customize the theme's appearance by modifying the following files:

- **Background Image**: Replace the background image in the theme folder with your own image.
- **Fonts**: If you'd like to change the font, update the `font` setting in the `theme.txt` file.
- **Colors**: Modify the color values in the `theme.txt` to change text, background, and other UI elements.

For more information on GRUB theme customization, refer to the [GRUB Theme Documentation](https://www.gnu.org/software/grub/manual/grub.html#Themes).

## Troubleshooting

- If you don't see the theme after updating GRUB, try running the following command to regenerate the GRUB configuration:

  ```bash
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ```

- If you encounter any issues with fonts or backgrounds, make sure the file paths in your `theme.txt` are correct.

## Contributing

If you find any bugs or have suggestions for improvements, feel free to open an issue or submit a pull request. Contributions are welcome!

## License

This theme is licensed under the [MIT License](LICENSE).

---

**Ayush Kumar Singh**  