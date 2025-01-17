#!/bin/bash

echo "Removing existing ./.config/nvim directory..."
rm -rf ./.config/nvim

echo "Copying ~/.config/nvim to ./.config/..."
cp -r ~/.config/nvim ./.config/

echo "Operation completed successfully."
