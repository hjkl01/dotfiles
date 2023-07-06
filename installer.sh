#!/bin/sh

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
}

SoftLinks() {
	ln -s ~/.dotfiles/config/gitconfig ~/.gitconfig
	mkdir -p ~/.config/pip
	ln -s ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
}

InstallOhMyZsh() {
	ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
	git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

	chsh -s $(which zsh)

	git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
	git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
	ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}

InstallNeovim() {
	ln -s ~/.dotfiles/nvim ~/.config/nvim
	ln -s ~/.dotfiles/config/pycodestyle ~/.config/pycodestyle

	# install python env
	python3 -m venv ~/.venv/py3
	~/.venv/py3/bin/pip install better_exceptions neovim black -i https://pypi.tuna.tsinghua.edu.cn/simple
}

Installasdf() {
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
	. $HOME/.asdf/asdf.sh

	# install nodejs
	asdf plugin add nodejs
	asdf list all nodejs
	asdf install nodejs 16.20.0
	asdf global nodejs 16.20.0

	asdf list all neovim
	asdf install neovim latest
	asdf global neovim latest
}

InstallOthers() {
	# Mac OS X 操作系统
	if [[ $(uname) == 'Darwin' ]]; then
		echo "mac"

		brew install alacritty tmux
		# 按照鼠须管
		brew install --cask squirrel
		# 参考配置
		git clone --depth=1 https://github.com/iDvel/rime-ice ~/Library/Rime

	# GNU/Linux操作系统
	# 需要重启
	elif [[ $(uname) == 'Linux' ]]; then
		echo "Linux"

		yay --noconfirm -S alacritty tmux fcitx5-rime

		echo "export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"

    fcitx5 &" >>~/.xprofile

		# 参考配置
		mkdir -p ~/.local/share/fcitx5/
		git clone --depth=1 https://github.com/iDvel/rime-ice ~/.local/share/fcitx5/rime

	# Windows NT操作系统
	else
		echo "Unkown system"
	fi

	# 配置alacritty
	mkdir -p ~/.config/alacritty/
	ln -s ~/.dotfiles/config/alacritty.yml ~/.config/alacritty
	ln -s ~/.dotfiles/config/tokyonignt_storm.yml ~/.config/alacritty

	# 配置tmux
	mkdir -p ~/.config/tmux/
	ln -s ~/.dotfiles/config/tmux.conf ~/.config/tmux/tmux.conf
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
