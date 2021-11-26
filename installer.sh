#!/bin/sh

judgeIfExists(){
    if [ -e $2 ]; then
        echo "$2 exists"
    else
        echo "run $1 $2"
        ln -s $1 $2
    fi
}


SoftLinks(){
    mkdir -p ~/.config/pip
    judgeIfExists ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
    judgeIfExists ~/.dotfiles/config/gitconfig ~/.gitconfig
}

InstallZsh(){
    echo "installing..."
    if which apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get install -y zsh git python3 python3-venv neovim npm
        # npm install -g n
        # && curl -sL https://deb.nodesource.com/setup | sudo bash -
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
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    if [ -e ~/.zshrc ];then
        echo "~/.zshrc exists"
    else
        ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
        chsh -s $(which zsh)
    fi
}

InstallThemesPlugins(){
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}

InstallNeovim(){
    git clone https://github.com/lesssound/nvim-config nvim
    sh nvim/installer.sh
}


# echo $@

# if [ $1 = 'y' ];
# then
#     SoftLinks
# fi

# if [[ "$@" =~ "link"  ]];then
#     echo "link in args, run soft link"
#     SoftLinks
# fi

# 如果可以正常访问GitHub、pip等 注释此行
SoftLinks
# install python env
python3 -m venv ~/.pyenv/py3

InstallZsh
InstallOhMyZsh
InstallThemesPlugins
InstallNeovim

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
