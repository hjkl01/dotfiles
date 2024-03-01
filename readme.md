## 我的配置

- alacritty
- tmux
- git
- oh-my-zsh
- neovim
- asdf
- python
  - pip
  - pycodestyle
- squirrel
  - rime-ice

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

#### install

```shell
# install zsh python3-venv neovim stylua
# if system is ubuntu/debian, use asdf install stylua
# install xclip in arch
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && cp env .env && sh ./installer.sh link # config git and pip mirror
cd ~/.dotfiles && cp env .env && sh ./installer.sh
```

#### crontab setting

```shell
# crontab -e or nvim /var/spool/cron/$USER
50 8 * * * cd $HOME/.dotfiles/ && git pull
# && nvim --headless "+Lazy! sync" +qa

# MacOS reload Squirrel
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
```

#### questions

> 如果有报错 清除缓存

```shell
rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin
```

#### refer from

- [NvChad](https://github.com/NvChad/NvChad)
