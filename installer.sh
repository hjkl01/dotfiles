#!/bin/sh

beforeInstall(){
   if [ -f ~/.zshrc ];then 
       echo "~/.zshrc exists"
       exit
   fi

   if [ -d ~/.oh-my-zsh ];then 
       echo "~/.oh-my-zsh exists"
       exit
   fi

   if [ -d ~/.~/.config/nvim ];then 
       echo "~/.config/nvim exists"
       exit
   fi
}

linkFile(){
   if [ -e $2 ]; then
      echo "$2 exists"
      exit
   else
      echo "run $1 $2"
      ln -s $1 $2
   fi
}

SoftLinks(){
   linkFile ~/.dotfiles/zsh/.zshrc ~/.zshrc
   mkdir -p ~/.config/pip
   linkFile ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
}

InstallZsh(){
   echo "installing..."
   if which apt-get >/dev/null; then
      sudo apt-get update -y && sudo apt-get install -y zsh git python3 python3-venv neovim
      # npm install -g n
      # && curl -sL https://deb.nodesource.com/setup | sudo bash -
   elif which brew >/dev/null;then
      brew install zsh git python3 neovim trash-cli
   elif which yum >/dev/null;then
      sudo yum install zsh git python3 neovim -y
   elif which pacman >/dev/null;then
      sudo pacman -Syy && sudo pacman -S --noconfirm zsh git python3 neovim xclip xorg-xclipboard trash-cli
   else
      echo "Does not support system version"
   fi
}

InstallOhMyZsh(){
    git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    chsh -s $(which zsh)
}

InstallThemesPlugins(){
   git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
   git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
   linkFile -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}

InstallNeovim(){
   # git clone --depth 1 https://github.com/hjkl01/init.lua init.lua
   # linkFile -s ~/.dotfiles/init.lua ~/.config/nvim
   git clone --depth 1 https://github.com/NvChad/NvChad  init.lua
   linkFile -s ~/.dotfiles/init.lua ~/.config/nvim
   linkFile -s ~/.dotfiles/config/pycodestyle ~/.config

   # install python env
   python3 -m venv ~/.venv/py3
   ~/.venv/py3/bin/pip install better_exceptions neovim black -i https://pypi.tuna.tsinghua.edu.cn/simple
   # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
   nvim --headless -c 'PackerSync'
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

beforeInstall
# 如果可以正常访问GitHub、pip等 注释此行
SoftLinks

InstallZsh
InstallOhMyZsh
InstallThemesPlugins
InstallNeovim

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
