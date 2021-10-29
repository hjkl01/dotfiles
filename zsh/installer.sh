#!/bin/sh

InstallZsh(){
    echo "installing..."
    if which apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get install -y zsh git python3 python3-venv make neovim npm && curl -sL https://deb.nodesource.com/setup | sudo bash -
    elif which brew >/dev/null;then
        brew install zsh git python3 neovim npm trash-cli
    elif which yum >/dev/null;then
        sudo yum install zsh git python3 neovim npm -y
    elif which pacman >/dev/null;then
        sudo pacman -Syy && sudo pacman -S --noconfirm zsh git python3 neovim xclip xorg-xclipboard npm trash-cli
    else
        echo "Does not support system version"
    fi
}

InstallOhMyZsh(){
    if [ -e ~/.oh-my-zsh ]; then
        echo "~/.oh-my-zsh exists"
    else
        git clone $1/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    if [ -e ~/.zshrc ];then
        echo "~/.zshrc exists"
    else
        ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
        chsh -s $(which zsh)
    fi
}

InstallThemesPlugins(){
	echo $1
    git clone $1/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone $1/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}


InstallZsh
InstallOhMyZsh $1
InstallThemesPlugins $1

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
