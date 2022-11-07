#!/bin/sh

beforeInstall() {
	if [ -f ~/.zshrc ]; then
		echo "~/.zshrc exists"
		exit
	fi

	if [ -d ~/.oh-my-zsh ]; then
		echo "~/.oh-my-zsh exists"
		exit
	fi

	if [ -d ~/.~/.config/nvim ]; then
		echo "~/.config/nvim exists"
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

# echo $@

# if [ $1 = 'y' ];
# then
#     SoftLinks
# fi

if [ "$1" =~ "link"  ];then
    echo "link in args, run soft link"
    SoftLinks
fi

# beforeInstall
InstallOhMyZsh
InstallNeovim

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
