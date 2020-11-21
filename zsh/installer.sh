#!/bin/sh

JudgeZshrcExist(){
    [[ ! -f ~/.zshrc ]] || mv ~/.zshrc ~/.zshrc_back
    # if [ ! -d "~/.zshrc" ]; then
    #     mv -f ~/.zshrc ~/.zshrc_back
    # fi
}

InstallZsh(){
    echo "installing..."
    if which apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get install -y zsh git python3.8 neovim npm
    elif which brew >/dev/null;then
        brew install zsh git python3.8 neovim npm
    elif which yum >/dev/null;then
        sudo yum install zsh git python3.8 neovim npm -y
    elif which pacman >/dev/null;then
        sudo pacman -S zsh git python3.8 neovim xclip xorg-xclipboard npm
    else
        echo "Does not support system version"
    fi
}

InstallOhMyZsh(){
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    chsh -s $(which zsh)
}

InstallThemesPlugins(){
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}


JudgeZshrcExist
InstallZsh
InstallOhMyZsh
InstallThemesPlugins

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
