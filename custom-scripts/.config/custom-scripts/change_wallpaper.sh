#!/bin/bash

# Folder to select the wallpaper from
wallpaper_folder="$HOME/.config/background" # Use $HOME instead of ~

# Ensure the folder exists
if [ ! -d "$wallpaper_folder" ]; then
  echo "The folder '$wallpaper_folder' does not exist."
  exit 1
fi

# List all files in the folder (assuming all files are images)
wallpapers=($wallpaper_folder/*)

# Check if there are any wallpapers in the folder
if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "No wallpapers found in the folder."
  exit 1
fi

# Select a random wallpaper from the list
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

echo ":: Setting wallpaper: $random_wallpaper"

# Use swww to set the wallpaper
swww img "$random_wallpaper" --transition-type random

# Path for the temporary copy and final image (blurred and possibly converted to PNG)
temp_image="/tmp/temp_wallpaper.jpg"                 # Temp location for the copy
output_image="$wallpaper_folder/current/current.png" # Final output image

# Make a copy of the selected wallpaper
cp "$random_wallpaper" "$temp_image"

# Check if the image is a .jpg or .jpeg, and convert it if necessary
image_extension="${random_wallpaper##*.}"
if [[ "$image_extension" == "jpg" || "$image_extension" == "jpeg" ]]; then
  # Convert jpg/jpeg to png (save as current.png)
  echo ":: Converting $random_wallpaper to PNG..."
  convert "$temp_image" "$output_image"
else
  # If the image is already png or another format, just use the temp image as output
  cp "$temp_image" "$output_image"
fi

# Apply a blur to the image (on the temporary copy)
echo ":: Applying blur to the image..."
convert "$output_image" -blur 0x8 "$output_image" # You can adjust the blur value (0x8) as needed

# Clean up the temporary copy if it's no longer needed
rm "$temp_image"

echo ":: Wallpaper set and blurred successfully!"
