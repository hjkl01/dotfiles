install : 
	python3 -m venv ~/.pyenv/py3 || echo ""
	ln -s ~/.dotfiles/.pip/ ~/ || echo ""
	sh zsh/installer.sh || echo ""
	sh nvim/installer.sh || echo ""
	ln -s ~/.dotfiles/.docker/ ~/ || echo ""
	ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig || echo ""
	ln -s ~/.dotfiles/js/npmrc ~/.npmrc || echo ""
	ln -s ~/.dotfiles/js/yarnrc ~/.yarnrc || echo ""
