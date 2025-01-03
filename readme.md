## 我的配置

<details><summary> ~/.gitconfig </summary>

```shell
# ~/.gitconfig
[pull]
	rebase = false
[user]
	email =
	name =
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[init]
	defaultBranch = master

[alias]
  lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
  lp = log --stat -p

; [http "https://github.com"]
; 	postBuffer = 524288000
; 	proxy = socks5://127.0.0.1:1080
; [https "https://github.com"]
; 	postBuffer = 524288000
; 	proxy = socks5://127.0.0.1:1080

; [url "https://gitclone.com/github.com"]
; [url "https://fastly.jsdelivr.net/https://github.com"]
; [url "https://testingcf.jsdelivr.net/https://github.com"]
; [url "https://raw.fastgit.org/https://github.com"]
; [url "https://ghproxy.com/https://github.com"]
; [url "https://cdn.jsdelivr.net/https://github.com"]
[url "https://gh.hjkl01.cn/proxy/https://github.com"]
	insteadOf = https://github.com
```

</details>

### install

- install fcitx5-rime alacritty zsh tmux fzf zoxide neovim lua stylua ripgrep
- install xclip in arch
- if system is ubuntu/debian, use asdf install stylua

```shell
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && cp env .env && bash ./installer.sh link # config git and pip mirror
```

```shell
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && cp env .env && bash ./installer.sh
```

### crontab setting

```shell
# crontab -e or nvim /var/spool/cron/$USER
50 8 * * * cd $HOME/.dotfiles/ && git pull
# && nvim --headless "+Lazy! sync" +qa
```

### usecase

```shell
# neovim

# if can't install nvim-treesitter
# Linux
sed -i 's|https://github.com|https://ghp.ci/https://github.com|g' ~/.local/share/nvim/lazy/nvim-treesitter/lua/nvim-treesitter/parsers.lua
# MacOS
sed -i "" 's|https://github.com|https://ghp.ci/https://github.com|g' ~/.local/share/nvim/lazy/nvim-treesitter/lua/nvim-treesitter/parsers.lua
# checkout before lazy sync
git -C ~/.local/share/nvim/lazy/nvim-treesitter/ checkout .

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
