#!/bin/bash

set -euo pipefail

timestamp=$(date +%Y%m%d%H%M%S)
BACKUP_DIR="$HOME/.local/dotfiles_backup_${timestamp}"
CONFIG_DIR="$HOME/.config"

mkdir -p "$BACKUP_DIR" "$CONFIG_DIR"

backup_if_exists() {
  local file="$1"
  if [ -e "$file" ]; then
    echo "Backing up $file"
    mv "$file" "$BACKUP_DIR/$(basename "$file")"
  fi
}

beforeInstall() {
  backup_if_exists "$HOME/.gitconfig"
  backup_if_exists "$HOME/.zshrc"
  backup_if_exists "$HOME/.oh-my-zsh"
  backup_if_exists "$CONFIG_DIR/nvim"
}

SoftLinks() {
  ln -sf "$HOME/.dotfiles/config/gitconfig" "$HOME/.gitconfig"
  ln -sf "$HOME/.dotfiles/config/gitignore" "$HOME/.gitignore"

  if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    mkdir -p "$HOME/.ssh"
    ssh-keygen -q -t rsa -b 4096 -C "" -f "$HOME/.ssh/id_rsa" -N ""
  fi

  mkdir -p "$CONFIG_DIR/pip"
  ln -sf "$HOME/.dotfiles/config/pip.conf" "$CONFIG_DIR/pip/pip.conf"
}

InstallOhMyZsh() {
  echo "source ~/.dotfiles/zsh/zshrc" >>"$HOME/.zshrc"
  echo ": 1700000000:0;ps aux | grep ssh" >>"$HOME/.zsh_history"

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
  fi

  for plugin in "zsh-autosuggestions" "zsh-syntax-highlighting"; do
    plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin"
    if [ ! -d "$plugin_dir" ]; then
      git clone --single-branch --depth 1 "https://github.com/zsh-users/$plugin" "$plugin_dir"
    else
      (cd "$plugin_dir" && git pull)
    fi
  done
  git clone --single-branch --depth 1 https://github.com/MichaelAquilina/zsh-you-should-use $HOME/.oh-my-zsh/custom/plugins/zsh-you-should-use

  ln -sf "$HOME/.dotfiles/zsh/Schminitz.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/Schminitz.zsh-theme"
}

InstallNeovim() {
  ln -sf "$HOME/.dotfiles/nvim" "$CONFIG_DIR/nvim"
  ln -sf "$HOME/.dotfiles/config/pycodestyle" "$CONFIG_DIR/pycodestyle"

  if [ ! -d "$HOME/.venv/py3" ]; then
    python3 -m venv "$HOME/.venv/py3"
    "$HOME/.venv/py3/bin/pip" install --upgrade pip
    "$HOME/.venv/py3/bin/pip" install better_exceptions neovim black ruff
  fi
}

Installasdf() {
  if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.15.0
  fi
  . "$HOME/.asdf/asdf.sh"
}

InstallOthers() {
  if [[ $(uname) == 'Darwin' ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install tmux fzf zoxide lua
    brew install --cask squirrel ghostty

    if [ ! -d "$HOME/Library/Rime" ]; then
      git clone --single-branch --depth=1 https://github.com/iDvel/rime-ice "$HOME/Library/Rime"
      ln -sf "$HOME/.dotfiles/config/rime/"*.yaml "$HOME/Library/Rime/"
    fi

  elif [[ $(uname) == 'Linux' ]]; then
    mkdir -p "$HOME/.dotfiles/bin"
    if [ ! -f "$HOME/.dotfiles/bin/chsrc" ]; then
      curl -L https://gitee.com/RubyMetric/chsrc/releases/download/pre/chsrc-x64-linux -o "$HOME/.dotfiles/bin/chsrc"
      chmod +x "$HOME/.dotfiles/bin/chsrc"
    fi
  fi

  mkdir -p "$CONFIG_DIR/ghostty"
  echo 'config-file = "../../.dotfiles/config/ghostty.config"' >"$CONFIG_DIR/ghostty/config"

  mkdir -p "$HOME/.tmux/plugins"

  for plugin in "tpm" "tmux-cpu"; do
    plugin_dir="$HOME/.tmux/plugins/$plugin"
    if [ ! -d "$plugin_dir" ]; then
      echo $plugin
      git clone --single-branch --depth=1 "https://github.com/tmux-plugins/$plugin" "$plugin_dir"
    fi
  done
  git clone --single-branch --depth=1 https://github.com/catppuccin/tmux ~/.tmux/plugins/tmux
}

main() {
  beforeInstall

  if [ "${1:-}" = "link" ]; then
    echo "Setting up GitHub proxy..."
    echo '[url "https://gh.hjkl01.cn/proxy/https://github.com"]
      insteadOf = https://github.com' >>"$HOME/.gitconfig"

    if [ ! -d "$HOME/.dotfiles" ]; then
      git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles "$HOME/.dotfiles"
      cp "$HOME/.dotfiles/env" "$HOME/.dotfiles/.env"
    fi

    SoftLinks
  fi

  InstallOhMyZsh
  InstallNeovim
  Installasdf
  InstallOthers

  echo "Installation complete! Please logout and relogin to apply changes."
}

main "$@"
