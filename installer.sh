#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)
echo $timestamp

beforeInstall() {
  if [ -f ~/.gitconfig ]; then
    echo "$HOME/.gitconfig exists"
    mv ~/.gitconfig ~/.gitconfig_$timestamp
  fi

  if [ -f ~/.zshrc ]; then
    echo "$HOME/.zshrc exists"
    mv ~/.zshrc ~/.zshrc_$timestamp
  fi

  if [ -d ~/.oh-my-zsh ]; then
    echo "$HOME/.oh-my-zsh exists"
    mv -f ~/.oh-my-zsh ~/.oh-my-zsh_$timestamp
  fi

  if [ -d ~/.config/nvim ]; then
    echo "$HOME/.config/nvim exists"
    mv -f ~/.config/nvim ~/.config/nvim_$timestamp
  fi

  mkdir -p ~/.config/
}

SoftLinks() {
  cp ~/.dotfiles/config/gitconfig ~/.gitconfig
  cp ~/.dotfiles/config/gitignore ~/.gitignore

  if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -q -t rsa -b 4096 -C "" -f ~/.ssh/id_rsa -N ""
  else
    echo "SSH key pair already exists."
  fi

  mkdir -p ~/.config/pip
  cp ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
}

InstallOhMyZsh() {
  # ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
  cp ~/.dotfiles/zsh/zshrc ~/.zshrc
  echo ": 1700000000:0;ps aux | grep ssh" >>~/.zsh_history

  git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  if [[ $SHELL == *"zsh"* ]]; then
    echo "shell is zsh now"
  else
    chsh -s $(which zsh)
  fi

  git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
  git clone --single-branch --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
  ln -s ~/.dotfiles/zsh/Schminitz.zsh-theme ~/.oh-my-zsh/custom/themes/Schminitz.zsh-theme
}

InstallNeovim() {
  ln -s ~/.dotfiles/nvim ~/.config/nvim
  ln -s ~/.dotfiles/config/pycodestyle ~/.config/pycodestyle

  # install python env
  python3 -m venv ~/.venv/py3
  ~/.venv/py3/bin/pip install better_exceptions neovim black ruff
}

Installasdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
  . $HOME/.asdf/asdf.sh

  # install nodejs
  asdf plugin add nodejs
  # asdf list all nodejs
  asdf install nodejs 20.17.1
  asdf global nodejs 20.17.1

  # asdf plugin add neovim
  # asdf list all neovim
  # asdf install neovim latest
  # asdf global neovim latest
}

InstallOthers() {
  # Mac OS X 操作系统
  if [[ $(uname) == 'Darwin' ]]; then
    echo "mac"

    brew install alacritty tmux fzf zoxide lua
    # 安装鼠须管
    brew install --cask squirrel
    # 参考配置
    git clone --single-branch --depth=1 https://github.com/iDvel/rime-ice ~/Library/Rime
    ln -s ~/.dotfiles/config/rime/*.yaml ~/Library/Rime
    # 重新部署
    # /Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload

  # GNU/Linux操作系统
  # 需要重启
  elif [[ $(uname) == 'Linux' ]]; then
    echo "Linux"

    # download chsrc
    mkdir bin
    curl -L https://gitee.com/RubyMetric/chsrc/releases/download/pre/chsrc-x64-linux -o bin/chsrc
    chmod +x ./bin/chsrc

    pacman --noconfirm -Syy

  # Windows NT操作系统
  else
    echo "Nonsupport system"
  fi

  # 配置alacritty
  mkdir -p ~/.config/alacritty/
  ln -s ~/.dotfiles/config/alacritty.toml ~/.config/alacritty

  # 配置tmux
  ln -s ~/.dotfiles/config/tmux.conf ~/.tmux.conf
  # mkdir -p ~/.config/tmux/
  # ln -s ~/.dotfiles/config/tmux.conf ~/.config/tmux/tmux.conf

  mkdir -p ~/.tmux/plugins
  git clone --single-branch --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  git clone --single-branch --depth=1 https://github.com/catppuccin/tmux ~/.tmux/plugins/tmux
  git clone --single-branch --depth=1 https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu
  # git clone --single-branch --depth=1 https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery

  # 配置zellij
  # zellij setup --dump-config > ~/.config/zellij/config.kdl
  # mkdir -p ~/.config/zellij/
  # ln -s ~/.dotfiles/config/zellij.kdl ~/.config/zellij/config.kdl
  # ln -s ~/.dotfiles/config/layouts ~/.config/zellij/layouts
}

# echo $@

# 定义一个函数，用于执行其他函数并捕获错误
execute_function() {
  local func_name=$1
  shift

  # 尝试执行函数
  if ! "$func_name" "$@"; then
    # 如果函数执行失败，输出错误信息并继续执行
    echo "Error executing function: $func_name"
  fi
}

execute_function beforeInstall

if [ "$1" = "link" ]; then
  echo "link in args, run soft link"
  SoftLinks
fi

execute_function InstallOhMyZsh
execute_function InstallNeovim
execute_function Installasdf
execute_function InstallOthers

echo "edit ~/.oh-my-zsh/themes/Schminitz.zsh-themes to update themes"
echo "finish ! logout and relogin"
