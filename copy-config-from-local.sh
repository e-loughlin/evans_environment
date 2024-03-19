#!/bin/bash

# Function to display the warning message and get user confirmation
confirm_action() {
    warning_message=$1
    read -p "$warning_message (Y/n): " choice
    case "$choice" in
        [yY]) return 0 ;;
        [nN]) return 1 ;;
        *) echo "Invalid choice. Please enter Y or n." ; confirm_action ;;
    esac
}

warning_message="WARNING! Replace evans_environment/.config/nvim/lua/user with LOCAL ~/.config/nvim/lua/user?"
if confirm_action "$warning_message"; then
	rm -rf ~/ws/evans_environment/.config/nvim/lua/user
	cp -r ~/.config/nvim/lua/user ~/ws/evans_environment/.config/nvim/lua/
	echo "Success..."
else
	echo "Exited without taking any action..."
fi

