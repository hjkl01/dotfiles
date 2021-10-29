
pyenv: ;@echo "Installing python virtualenv"
	python3 -m venv ~/.pyenv/py3 || echo ""

link: ;@echo "Symbolic links"
	mkdir -p ~/.config/pip
	sh zsh/softlinks.sh

install: pyenv
	@echo "Installing ohmyzsh and neovim config using github address"
	export DOMAIN="https://github.com"
	sh zsh/installer.sh ${DOMAIN} || echo ""
	git clone ${DOMAIN}/lesssound/vimrc nvim
	sh nvim/installer.sh || echo ""

gitee: pyenv link
	@echo "Installing ohmyzsh and neovim config using gitee address"
	sh zsh/gitee_installer.sh || echo ""
	git clone https://gitee.com/lesssound/vimrc.git nvim
	sh nvim/installer.sh || echo ""

cnpmjs: pyenv link
	@echo "Installing ohmyzsh and neovim config using gitee address"
	export DOMAIN="https://github.com.cnpmjs.org"
	sh zsh/installer.sh || echo ""
	# git clone https://gitee.com/lesssound/vimrc.git nvim
	# sh nvim/installer.sh || echo ""
