#!/bin/bash

# Show keyboard shortcuts using Yad in Floating Mode
yad --title="Hyprland Keyboard Shortcuts" \
    --width=700 --height=700 \
    --center --fixed \
    --list --column="Shortcut  Action" \
    --text="<b><big>Hyprland Keyboard Shortcuts</big></b>\n\n<i>Boost your workflow with these essential keybindings.</i>\n" \
    " " \
    "<b>WINDOW MANAGEMENT</b>" \
    "Super + Return                 →       Open terminal" \
    "Super + Q                      →       Close active window" \
    "Super + SHIFT + Q              →       Force quit window" \
    "Super + F                      →       Toggle fullscreen" \
    "Super + SHIFT + F              →       Toggle floating mode" \
    "Super + SHIFT + T              →       Toggle all floating" \
    "Super + P                      →       Toggle pseudo tiling" \
    "Super + J                      →       Toggle split direction" \
    "Super + [1-9]                  →       Switch to workspace" \
    "Super + SHIFT + [1-9]          →       Move window to workspace" \
    "Super + S                      →       Toggle scratchpad" \
    "Super + SHIFT + S              →       Move window to scratchpad" \
    " " \
    "<b>WINDOW MOVEMENT</b>" \
    "Super + Arrow Keys             →       Focus window in direction" \
    "Super + Alt + Arrow            →       Swap window in direction" \
    "Super + SHIFT + Arrow          →       Resize active window" \
    "Super + Mouse Drag             →       Move window" \
    "Super + Right Mouse Drag       →       Resize window" \
    "Alt + Tab                      →       Cycle through windows" \
    " " \
    "<b>APPLICATIONS</b>" \
    "Super + D                      →       Launch Rofi (app launcher)" \
    "Super + SHIFT + D              →       Launch nwg-drawer (app grid)" \
    "Super + N                      →       Open file manager" \
    "Super + O                      →       Launch Brave browser" \
    "Super + Z                      →       Launch Zen browser" \
    "Super + T                      →       Open floating terminal with system info" \
    "Super + V                      →       Open clipboard history" \
    "Super + SHIFT + V              →       Clear clipboard history" \
    "Super + L                      →       Lock screen with hyprlock" \
    "Super + SHIFT + E              →       Open wlogout menu" \
    "Print                          →       Screenshot selected area" \
    " " \
    "<b>SYSTEM CONTROLS</b>" \
    "Super + C                      →       Change wallpaper randomly" \
    "Super + SHIFT + C              →       Open wallpaper selector" \
    "Super + M                      →       Exit Hyprland" \
    "Volume Keys                    →       Adjust volume" \
    "Brightness Keys                →       Adjust screen brightness" \
    "Media Keys                     →       Control media playback" \
    --scroll \
    --button="Close":0 &

# Ensure it opens in floating mode
sleep 0.2
hyprctl dispatch movewindow tofloating