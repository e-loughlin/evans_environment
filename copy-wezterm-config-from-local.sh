#!/bin/bash

echo "Removing existing ./.config/wezterm directory..."
rm -rf ./.config/wezterm

echo "Copying ~/.config/wezterm to ./.config/..."
cp -r ~/.config/wezterm ./.config/

echo "Operation completed successfully."
