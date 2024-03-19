#!/bin/bash

# Fonts
mkdir ~/.local/share/fonts
cp ./fonts/* ~/.local/share/fonts 

# Dependencies
sudo apt-get install tmux
sudo apt-get install curl

# neovim installation
nvim -v
status=$?
if [ $status? != 0 ]
then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv ./nvim.appimage /usr/bin/nvim
fi


# RipGrep
rg --version
status=$?

if [ $status? != 0 ]
then
	RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
	curl -Lo ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}_amd64.deb"
	sudo apt install -y ./ripgrep.deb
	rm -rf ripgrep.deb
fi

# fd-find
sudo apt-get install fd-find

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

warning_message="Replace ~/.config/tmux and ~/.config/nvim?"
if confirm_action "$warning_message"; then
	rm -rf ~/.config/tmux
	rm -rf ~/.config/nvim
	cp -r ./.config/* ~/.config/
else
	echo "~/.config/ files unaltered..."
fi

warning_message="Replace ~/.bashrc?"
if confirm_action "$warning_message"; then
	cp .bashrc ~/.bashrc
else
	echo "~/.bashrc unaltered..."
fi

warning_message="Replace ~/.vimrc?"
if confirm_action "$warning_message"; then
	cp .vimrc ~/.vimrc
else
	echo "~/.vimrc unaltered..."
fi


warning_message="Replace ~/.nvimrc?"
if confirm_action "$warning_message"; then
	cp .nvimrc ~/.nvimrc
else
	echo "~/.nvimrc unaltered..."
fi
# Environment: Commented out because Danger
# cp ./.bashrc ~/.bashrc

# BASH Completion for TMUX 
completion_file=~/.bash_completion_tmux
if [ ! -f "$completion_file" ]; then
    echo "Downloading tmux completion script..."
    curl -o "$completion_file" https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux
    echo "Downloaded tmux completion script to $completion_file"
    echo -e "/n/n# bash completion for tmux" >> ~/.bashrc
    echo "source ${completion_file}" >> ~/.bashrc
else
    echo "tmux completion script already exists at $completion_file"
fi


# Install Node, Yarn, and NPM
warning_message="Install Node, Yarn and NPM?"
if confirm_action "$warning_message"; then
	sudo apt update
	sudo apt install nodejs npm
	npm install --global yarn
else
	echo "Node, Yarn, NPM installation skipped..."
fi
