#!/bin/bash

# Monitor names (Ensure they match 'hyprctl monitors' output)
INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

# Check if the external monitor is connected
if ! hyprctl monitors all | grep -q "$EXTERNAL"; then
  # If not connected, only the laptop option is available
  options="Laptop Only"
else
  # If connected, show all three options
  options="Laptop Only\nDual Monitors\nExternal Only"
fi

# Display the menu using Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Monitor Mode:" -theme ~/.config/rofi/launchers/type-6/style-9.rasi)

# Function to move all workspaces to a specific monitor
move_workspaces_to() {
  local target=$1
  # Get a list of all current workspace IDs
  workspaces=$(hyprctl workspaces -j | jq '.[] | .id')
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor "$ws $target"
  done
}

case $chosen in
"Laptop Only")
  # Move everything to the laptop monitor first
  move_workspaces_to "$INTERNAL"
  hyprctl keyword monitor "$INTERNAL, preferred, 0x0, 1"
  hyprctl keyword monitor "$EXTERNAL, disable"
  notify-send "Monitor Profile" "Laptop Screen Only" -i display
  ;;

"Dual Monitors")
  # Enable both monitors side by side
  hyprctl keyword monitor "$INTERNAL, preferred, 0x0, 1"
  hyprctl keyword monitor "$EXTERNAL, preferred, 1920x0, 1"
  notify-send "Monitor Profile" "Dual Monitor Setup" -i display
  ;;

"External Only")
  # 1. Enable the external monitor first (without disabling laptop yet)
  hyprctl keyword monitor "$EXTERNAL, preferred, 0x0, 1"
  sleep 0.5 # Small delay to ensure the system recognizes the new monitor

  # 2. Move all workspaces from laptop to the external monitor
  move_workspaces_to "$EXTERNAL"

  # 3. Now it is safe to disable the internal laptop screen
  hyprctl keyword monitor "$INTERNAL, disable"

  notify-send "Monitor Profile" "External Screen Only" -i display
  ;;
esac
