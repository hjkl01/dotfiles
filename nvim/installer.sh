#!/bin/sh

JudgeVimPath(){
    if [ ! -d "~/.vim" ]; then
        filename=`date '+%Y%m%d'`
        echo $filename
        mv -f ~/.vim ~/.vim_old$filename
    fi
    mkdir ~/.config/
}

ConfigVim(){
    git clone https://github.com/formateddd/vimrc ~/.vim

    cp ~/.vim/config/vimrc ~/.vimrc
    #cp ~/.vim/config/flake8 ~/.flake8

    vim +PlugInstall +qall
    echo "vim plugins install success"

    # default python virtualenv
    pip install black jedi -i https://pypi.tuna.tsinghua.edu.cn/simple
    echo "Installed the Vim configuration successfully, Enjoy it ! :-)"
}

JudgeNvimPath(){
    if [ ! -d "~/.config/nvim" ]; then
        filename=`date '+%Y%m%d'`
        echo $filename
        mv -f ~/.config/nvim ~/.config/nvim_old$filename
    fi
}

ConfigNvim(){
    ln -s ~/.dotfiles/nvim/ ~/.config/

    mkdir -p ~/.local/share/nvim/site/autoload
    cp -r ~/.config/nvim/autoload ~/.local/share/nvim/site/

    nvim +PlugInstall +qall
    # nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"
    echo "vim plugins install success"

    # default python virtualenv
    pip install neovim pynvim black jedi -i https://pypi.tuna.tsinghua.edu.cn/simple
    echo "while copy Chinese , export LC_ALL="zh_CN.UTF-8" "
    echo "Installed the Vim configuration successfully, Enjoy it ! :-)"
}


JudgeNvimPath
ConfigNvim
