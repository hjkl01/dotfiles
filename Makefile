install : 
	sh zsh/installer.sh
	sh vim/installer.sh
	ln -s docker/ ~/.docker/
	ln -s git/gitconfig ~/.gitconfig
