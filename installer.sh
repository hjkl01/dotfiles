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
  backup_if_exists "$CONFIG_DIR/nvim"
  mkdir -p "$HOME/.dotfiles/bin"
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
  mkdir -p "$CONFIG_DIR/uv"
  ln -sf "$HOME/.dotfiles/config/uv.toml" "$CONFIG_DIR/uv/uv.toml"
}

InstallOhMyZsh() {
  echo "source ~/.dotfiles/zsh/zshrc" >>"$HOME/.zshrc"
  echo ": 1700000000:0;ps aux | grep ssh" >>"$HOME/.zsh_history"

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
  fi

  for plugin in "zsh-autosuggestions" "zsh-syntax-highlighting" "zsh-completions"; do
    plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin"
    if [ ! -d "$plugin_dir" ]; then
      git clone --single-branch --depth 1 "https://github.com/zsh-users/$plugin" "$plugin_dir"
    else
      (cd "$plugin_dir" && git pull)
    fi
  done
  if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-you-should-use ]; then
    git clone --single-branch --depth 1 https://github.com/MichaelAquilina/zsh-you-should-use $HOME/.oh-my-zsh/custom/plugins/zsh-you-should-use
  fi

  if [ ! -d $HOME/.oh-my-zsh/custom/themes/Schminitz.zsh-theme ]; then
    ln -sf "$HOME/.dotfiles/zsh/Schminitz.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/Schminitz.zsh-theme"
  fi
}

InstallNeovim() {
  ln -sf "$HOME/.dotfiles/nvim" "$CONFIG_DIR/nvim"
  ln -sf "$HOME/.dotfiles/config/pycodestyle" "$CONFIG_DIR/pycodestyle"

  if [ ! -d "$HOME/.venv/py3" ]; then
    python3 -m venv "$HOME/.venv/py3"
    "$HOME/.venv/py3/bin/pip" install --upgrade pip
    "$HOME/.venv/py3/bin/pip" install better_exceptions neovim black ruff debugpy
  fi
}

Installasdf() {
  # 检测系统
  OS=$(uname -s)
  ARCH=$(uname -m)

  # 转换架构名称
  case "$ARCH" in
  x86_64)
    ARCH="amd64"
    ;;
  aarch64 | arm64)
    ARCH="arm64"
    ;;
  *)
    echo "不支持的架构: $ARCH"
    exit 1
    ;;
  esac

  # 转换系统名称
  case "$OS" in
  Linux)
    OS="linux"
    ;;
  Darwin)
    OS="darwin"
    ;;
  *)
    echo "不支持的系统: $OS"
    exit 1
    ;;
  esac

  # 获取最新版本号
  LATEST_VERSION=$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  echo "检测到 asdf 最新版本: $LATEST_VERSION"

  # 拼接下载 URL
  FILE="asdf-$LATEST_VERSION-$OS-$ARCH.tar.gz"
  URL="https://gh.hjkl01.cn/https://github.com/asdf-vm/asdf/releases/download/$LATEST_VERSION/$FILE"

  # 判断是否已存在
  if [ -f "$FILE" ]; then
    echo "⚠️ 文件已存在: $FILE, 跳过下载"
  else
    echo "⬇️  下载: $URL"
    curl -L -o "$FILE" "$URL"
    tar -C ~/.dotfiles/bin -xzf "$FILE"
    rm $FILE
  fi

  echo "完成！请运行: asdf --version"

}

InstallOthers() {
  if [[ $(uname) == 'Darwin' ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install tmux fzf zoxide lua asdf
    brew install --cask squirrel ghostty

    if [ ! -d "$HOME/Library/Rime" ]; then
      git clone --single-branch --depth=1 https://github.com/iDvel/rime-ice "$HOME/Library/Rime"
      ln -sf "$HOME/.dotfiles/config/rime/"*.yaml "$HOME/Library/Rime/"
    fi

  elif [[ $(uname) == 'Linux' ]]; then
    if [ ! -f "$HOME/.dotfiles/bin/chsrc" ]; then
      curl -L https://gitee.com/RubyMetric/chsrc/releases/download/pre/chsrc-x64-linux -o "$HOME/.dotfiles/bin/chsrc"
      chmod +x "$HOME/.dotfiles/bin/chsrc"
    fi
  fi

  if [ ! -f "$CONFIG_DIR/ghostty" ]; then
    mkdir -p "$CONFIG_DIR/ghostty"
    echo 'config-file = "../../.dotfiles/config/ghostty.config"' >"$CONFIG_DIR/ghostty/config"
  fi

  mkdir -p "$HOME/.tmux/plugins"

  for plugin in "tpm" "tmux-cpu" "tmux-yank" "tmux-resurrect"; do
    plugin_dir="$HOME/.tmux/plugins/$plugin"
    if [ ! -d "$plugin_dir" ]; then
      echo $plugin
      git clone --single-branch --depth=1 "https://github.com/tmux-plugins/$plugin" "$plugin_dir"
    fi
  done
  if [ ! -d ~/.tmux/plugins/tmux/ ]; then
    git clone --single-branch --depth=1 https://github.com/catppuccin/tmux ~/.tmux/plugins/tmux
  fi
}

main() {
  beforeInstall

  if [ "${1:-}" = "link" ]; then
    # echo "Setting up GitHub proxy..."
    # echo '[url "https://gh.hjkl01.cn/proxy/https://github.com"]
    #   insteadOf = https://github.com' >>"$HOME/.gitconfig"

    SoftLinks
  fi

  if [ ! -d "$HOME/.dotfiles" ]; then
    git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles "$HOME/.dotfiles"
    cp "$HOME/.dotfiles/env" "$HOME/.dotfiles/.env"
  fi

  InstallOhMyZsh
  InstallNeovim
  Installasdf
  InstallOthers

  echo "Installation complete! Please logout and relogin to apply changes."
}

main "$@"
