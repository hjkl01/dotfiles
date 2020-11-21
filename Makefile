install : 
	python3 -m venv ~/.pyenv/py3 || echo ""
	ln -s ~/.dotfiles/pip/pip.conf ~/.pip/pip.conf || mkdir ~/.pip && ln -s ~/.dotfiles/pip/pip.conf ~/.pip/pip.conf || echo ""
	sh zsh/installer.sh || echo ""
	sh nvim/installer.sh || echo ""
	ln -s ~/.dotfiles/docker/ ~/.docker/ || mkdir ~/.docker && ln -s ~/.dotfiles/docker/ ~/.docker/ || echo ""
	ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig || echo ""
	ln -s ~/.dotfiles/js/npmrc ~/.npmrc || echo ""
	ln -s ~/.dotfiles/js/yarnrc ~/.yarnrc || echo ""
