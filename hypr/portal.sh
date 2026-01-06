#!/bin/bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
killall xdg-desktop-portal-gtk
sleep 1

/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &
