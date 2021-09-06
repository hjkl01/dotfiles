
pyenv: ;@echo "Installing python virtualenv"
	python3 -m venv ~/.pyenv/py3 || echo ""

link: ;@echo "Symbolic links"
	mkdir -p ~/.config/pip
	ln -s ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf || echo ""
	ln -s ~/.dotfiles/config/gitconfig ~/.gitconfig || echo ""
	ln -s ~/.dotfiles/config/npmrc ~/.npmrc || echo ""
	ln -s ~/.dotfiles/config/yarnrc ~/.yarnrc || echo ""

github: pyenv
	@echo "Installing ohmyzsh and neovim config using github address"
	sh zsh/installer.sh || echo ""
	git clone https://github.com/formattedd/vimrc nvim
	sh nvim/installer.sh || echo ""

gitee: pyenv link
	@echo "Installing ohmyzsh and neovim config using gitee address"
	sh zsh/gitee_installer.sh || echo ""
	git clone https://gitee.com/formattedd/vimrc nvim
	sh nvim/installer.sh || echo ""
