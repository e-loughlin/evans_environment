!/bin/bash

## Function to display the warning message and get user confirmation
confirm_action() {
    warning_message=$1
    echo -n "$warning_message (Y/n): "
    read choice
    case "$choice" in
        [yY]) return 0 ;;
        [nN]) return 1 ;;
        *) echo "Invalid choice. Please enter Y or n." ; confirm_action "$warning_message" ;;
    esac
}

# Fonts
warning_message="Install Fonts?"
if confirm_action "$warning_message"; then
	mkdir ~/.local/share/fonts
	cp ./fonts/* ~/.local/share/fonts 
fi

warning_message="Install bash completion?"
if confirm_action "$warning_message"; then
	brew install bash completion
	echo "source <(kubectl completion zsh)" >> ~/.zshrc
fi


# Dependencies
warning_message="Install Dependencies?"
if confirm_action "$warning_message"; then
	brew install tmux
	brew install curl

	# neovim installation
	brew install neovim
	brew install pass

	# fd-find
	brew install fd
	brew install ripgrep
	brew install fzf
	brew install sourcetree
fi

warning_message="Configure Password Manager?"
if confirm_action "$warning_message"; then
	git clone git@github.com:e-loughlin/password-store ~/.password-store
	cd ~/.password-store
	gpg --import ~/.password-store/public.key
 	gpg --import ~/.password-store/private.key
else
	echo "Skipped..."
fi

warning_message="Install powerlevel10k?"
if confirm_action "$warning_message"; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
	source ~/.zshrc
	p10k configure
else
	echo "Skipped..."
fi

warning_message="Set up Git?"
if confirm_action "$warning_message"; then
	git config --global push.autoSetupRemote true
	git config --global user.name "Evan Loughlin"
	git config --global user.email "emloughl@gmail.com"
else
	echo "Skipped..."
fi

warning_message="Replace ~/.config/nvim?"
if confirm_action "$warning_message"; then
	rm -rf ~/.config/nvim
	cp -r ./.config/nvim ~/.config/
else
	echo "Skipped..."
fi

warning_message="Replace ~/.config/tmux"
if confirm_action "$warning_message"; then
	rm -rf ~/.config/tmux
	cp -r ./.config/tmux ~/.config/
else
	echo "Skipped..."
fi


warning_message="Replace ~/.bashrc?"
if confirm_action "$warning_message"; then
	cp .bashrc ~/.bashrc
else
	echo "~/.bashrc unaltered..."
fi

warning_message="Replace ~/.zshrc?"
if confirm_action "$warning_message"; then
	cp .zshrc ~/.zshrc
else
	echo "~/.zshrc unaltered..."
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

# Install Node, Yarn, and NPM
warning_message="Install Node, Yarn and NPM?"
if confirm_action "$warning_message"; then
	brew update
	brew install node
	npm install --global yarn
else
	echo "Node, Yarn, NPM installation skipped..."
fi

# LaTeX Stuff
warning_message="Install LaTeX Stuff?"
if confirm_action "$warning_message"; then
	sudo apt-get update
	sudo apt-get install texlive-base texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex
	sudo apt-get install latexmk
else
	echo "LaTeX stuff skipped..."
fi

warning_message="Install ImageMagick?"
if confirm_action "$warning_message"; then
	brew update
	brew install imagemagick
else
	echo "ImageMagick installation skipped..."
fi


warning_message="Install Ghostscript? (PDF Compression)"
if confirm_action "$warning_message"; then
	brew update
	brew install ghostscript
	mv /opt/homebrew/bin/gs /opt/homebrew/bin/ghostscript
else
	echo "ImageMagick installation skipped..."
fi
