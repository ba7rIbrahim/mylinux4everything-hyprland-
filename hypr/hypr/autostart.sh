#!/usr/bin/env sh

# 1. Kill existing processes to ensure a clean startup
killall -q mako
killall -q xdg-desktop-portal-wlr
killall -q xdg-desktop-portal-hyprland
killall -q xdg-desktop-portal

# 2. Update DBus environment (essential for notifications and portals)
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# 3. Start portals in the background
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &

# 4. Start mako notification daemon after the environment stabilizes
sleep 1
mako &
