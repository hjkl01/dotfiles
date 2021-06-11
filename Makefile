
pyenv: ;@echo "Installing python virtualenv"
	python3 -m venv ~/.pyenv/py3 || echo ""

link: ;@echo "Symbolic links"
	ln -s ~/.dotfiles/.pip/ ~/ || echo ""
	ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig || echo ""
	ln -s ~/.dotfiles/js/npmrc ~/.npmrc || echo ""
	ln -s ~/.dotfiles/js/yarnrc ~/.yarnrc || echo ""

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
