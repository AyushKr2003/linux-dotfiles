#!/bin/sh
# swayidle -w \
#         timeout 10 "hyprlock" \  # Lock the screen after 10 seconds of inactivity
#             resume '' \  
#         timeout 120 'hyprctl dispatch dpms off' \  # Turn off the screen after 120 seconds
#             resume 'hyprctl dispatch dpms on' \  # Turn on the screen when resumed
#         timeout 600 'systemctl suspend'  # Suspend the system after 600 seconds
