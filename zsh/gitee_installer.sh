#!/bin/sh

JudgeZshrcExist(){
    if [ -f "~/.zshrc" ]; then
        mv ~/.zshrc ~/.zshrc_back
    fi
}

InstallZsh(){
    echo "installing..."
    if which apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get install -y zsh git python3 python3-venv make neovim npm && curl -sL https://deb.nodesource.com/setup | sudo bash -
    elif which brew >/dev/null;then
        brew install zsh git python3 neovim npm trash-cli
    elif which yum >/dev/null;then
        sudo yum install zsh git python3 neovim npm -y
    elif which pacman >/dev/null;then
        sudo pacman -S --noconfirm zsh git python3 neovim xclip xorg-xclipboard npm trash-cli
    else
        echo "Does not support system version"
    fi
}

InstallOhMyZsh(){
    git clone https://gitee.com/formattedd/ohmyzsh ~/.oh-my-zsh
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    chsh -s $(which zsh)
}

InstallThemesPlugins(){
    git clone https://gitee.com/formattedd/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://gitee.com/formattedd/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}


JudgeZshrcExist
InstallZsh
InstallOhMyZsh
InstallThemesPlugins

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
