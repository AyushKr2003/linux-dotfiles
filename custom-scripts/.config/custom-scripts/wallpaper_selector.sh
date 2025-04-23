#!/bin/bash

# Directory configurations
wallpaper_folder="$HOME/.config/background/"
current_dir="$wallpaper_folder/current"

# Ensure directories exist
mkdir -p "$current_dir"

# Transition config for swww
FPS=60
TYPE="random"
DURATION=2
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Initialize swww if not running
swww query || swww init

# Retrieve image files
PICS=($(find "${wallpaper_folder}" -maxdepth 1 -type f | grep -E ".jpg$|.jpeg$|.png$|.gif$"))

# Rofi command for wallpaper selection
rofi_command="rofi -show -dmenu -config ~/.config/rofi/themes/rofi-wall.rasi"

# Generate menu for rofi
menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
    else
      printf "$(basename "${PICS[$i]}")\n"
    fi
  done
}

# Display selection menu and get choice
choice=$(menu | ${rofi_command})

# No choice case
if [[ -z $choice ]]; then
  echo "No wallpaper selected."
  exit 0
fi

# Find the selected file
selected_wallpaper=""
for pic in "${PICS[@]}"; do
  filename=$(basename "$pic")
  name_without_ext=$(basename "$filename" | cut -d. -f1)
  if [[ "$name_without_ext" == "$choice" ]]; then
    selected_wallpaper="$pic"
    break
  fi
done

if [[ -z $selected_wallpaper ]]; then
  echo "Image not found."
  exit 1
fi

echo ":: Selected wallpaper: $selected_wallpaper"

# Set the wallpaper with swww
notify-send -i "$selected_wallpaper" "Changing wallpaper" -t 1500
swww img "$selected_wallpaper" $SWWW_PARAMS

# Path for the temporary copy and final images
temp_image="/tmp/temp_wallpaper.jpg"
output_image="$current_dir/current_wall.png"
output_blur="$current_dir/current.png"

# Make a copy of the selected wallpaper
cp "$selected_wallpaper" "$temp_image"

# Check if the image is a .jpg or .jpeg, and convert it if necessary
image_extension="${selected_wallpaper##*.}"
if [[ "$image_extension" == "jpg" || "$image_extension" == "jpeg" ]]; then
  # Convert jpg/jpeg to png (save as current.png)
  echo ":: Converting $selected_wallpaper to PNG..."
  convert "$temp_image" "$output_image"
else
  # If the image is already png or another format, just copy it
  cp "$temp_image" "$output_image"
fi

# Create a non-blurred copy
cp "$output_image" "$current_dir/current_wall.png"

# Apply a blur to create the blurred version
echo ":: Applying blur to the image..."
convert "$output_image" -blur 0x8 "$output_blur"

# Clean up the temporary copy
rm "$temp_image"

echo ":: Wallpaper set and processed successfully!"

