## 我的配置

### try in docker

```
docker run -ti --rm -v $(pwd):/projects formattedd/dotfiles zsh
```

### Before Install
- install fcitx5-rime alacritty zsh tmux fzf zoxide neovim lua stylua ripgrep
- install xclip in arch
- if system is ubuntu/debian, use asdf install stylua

### Install Auto

```shell
curl -fsSL https://gh.hjkl01.cn/proxy/https://raw.githubusercontent.com/hjkl01/dotfiles/refs/heads/master/installer.sh -o install.sh && chmod +x install.sh && bash ./install.sh link
# curl -fsSL https://gh.hjkl01.cn/proxy/https://raw.githubusercontent.com/hjkl01/dotfiles/refs/heads/master/installer.sh -o install.sh && chmod +x install.sh && bash ./install.sh
chsh -s zsh
```

### Install Manual 
- copy gitconfig

```shell
[url "https://gh.hjkl01.cn/proxy/https://github.com"]
	insteadOf = https://github.com
```

```shell
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && cp env .env && bash ./installer.sh link # config git and pip mirror
chsh -s zsh
```

```shell
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && cp env .env && bash ./installer.sh
chsh -s zsh
```

### crontab setting

```shell
# crontab -e or nvim /var/spool/cron/$USER
50 8 * * * cd $HOME/.dotfiles/ && git pull
# && nvim --headless "+Lazy! sync" +qa
```

### usecase

```shell
# tmux
# Press prefix + I (capital i, as in Install) to fetch the plugin.
prefix + I

# fcitx5-rime
# install ruby
git clone --depth=1 https://github.com/Mark24Code/rime-auto-deploy
cd rime-auto-deploy
./installer.rb

# write to /etc/environment
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# MacOS reload Squirrel
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
```

### software recommand

```shell
tree
htop
lsof
ncdu
rsync
proxychains-ng
lazygit
https://github.com/sxyazi/yazi
https://github.com/yorukot/superfile
```

### questions

> 如果Neovim有报错 清除缓存

```shell
rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin
```

### wsl

> install win32yank in wsl
> windows alacritty config path: ~\AppData\Roaming\alacritty\alacritty.toml

### refer from

- [NvChad](https://github.com/NvChad/NvChad)
- [LazyVim](https://github.com/LazyVim/LazyVim)
