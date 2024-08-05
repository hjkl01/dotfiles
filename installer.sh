#!/bin/bash

beforeInstall() {
	if [ -f ~/.zshrc ]; then
		echo "$HOME/.zshrc exists"
		exit
	fi

	if [ -d ~/.oh-my-zsh ]; then
		echo "$HOME/.oh-my-zsh exists"
		exit
	fi

	if [ -d ~/.~/.config/nvim ]; then
		echo "$HOME/.config/nvim exists"
		exit
	fi

	mkdir -p ~/.config/
}

SoftLinks() {
	ln -s ~/.dotfiles/config/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/config/gitignore ~/.gitignore

	mkdir -p ~/.config/pip
	ln -s ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
}

InstallOhMyZsh() {
	ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
	echo ": 1700000000:0;ps aux | grep ssh" >>~/.zsh_history

	git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

	if [[ $SHELL == *"zsh"* ]]; then
		echo "shell is zsh now"
	else
		chsh -s $(which zsh)
	fi

	git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
	git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
	ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}

InstallNeovim() {
	ln -s ~/.dotfiles/nvim ~/.config/nvim
	ln -s ~/.dotfiles/config/pycodestyle ~/.config/pycodestyle

	# install python env
	python3 -m venv ~/.venv/py3
	~/.venv/py3/bin/pip install better_exceptions neovim black ruff -i https://pypi.tuna.tsinghua.edu.cn/simple
}

Installasdf() {
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
	. $HOME/.asdf/asdf.sh

	# install nodejs
	asdf plugin add nodejs
	asdf list all nodejs
	asdf install nodejs 20.15.1
	asdf global nodejs 20.15.1

	asdf list all neovim
	asdf install neovim latest
	asdf global neovim latest
}

InstallOthers() {
	# Mac OS X 操作系统
	if [[ $(uname) == 'Darwin' ]]; then
		echo "mac"

		brew install alacritty tmux fzf zoxide
		# 按照鼠须管
		brew install --cask squirrel
		# 参考配置
		git clone --single-branch --depth=1 https://github.com/iDvel/rime-ice ~/Library/Rime
		ln -s ~/.dotfiles/config/rime/*.yaml ~/Library/Rime

	# GNU/Linux操作系统
	# 需要重启
	elif [[ $(uname) == 'Linux' ]]; then
		echo "Linux"

		yay --noconfirm -S alacritty tmux fzf zoxide fcitx5 fcitx5-chinese-addons fcitx5-im fcitx5-configtool

    mkdir -p ~/.local/share/fcitx5/
    git clone --single-branch --depth=1 https://github.com/iDvel/rime-ice ~/.local/share/fcitx5/rime
    ln -s ~/.dotfiles/config/rime/*.yaml ~/.local/share/fcitx5/rime/

		echo "export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx5 &" >>~/.xprofile

		# 参考配置

	# Windows NT操作系统
	else
		echo "Nonsupport system"
	fi

	# 配置alacritty
	mkdir -p ~/.config/alacritty/
	ln -s ~/.dotfiles/config/alacritty.toml ~/.config/alacritty

	# 配置tmux
	ln -s ~/.dotfiles/config/tmux.conf ~/.tmux.conf
	# mkdir -p ~/.config/tmux/
	# ln -s ~/.dotfiles/config/tmux.conf ~/.config/tmux/tmux.conf

	mkdir -p ~/.tmux/plugins
	git clone --single-branch --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	git clone --single-branch --depth=1 https://github.com/catppuccin/tmux ~/.tmux/plugins/tmux

	# 配置zellij
  # zellij setup --dump-config > ~/.config/zellij/config.kdl
	# mkdir -p ~/.config/zellij/
	# ln -s ~/.dotfiles/config/zellij.kdl ~/.config/zellij/config.kdl
	# ln -s ~/.dotfiles/config/layouts ~/.config/zellij/layouts
}

# echo $@

if [ "$1" = "link" ]; then
	echo "link in args, run soft link"
	SoftLinks
fi

beforeInstall
InstallOhMyZsh
InstallNeovim
Installasdf
InstallOthers

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
