## 我的配置

- git
- zsh
- neovim
- asdf
- python
  - pip
  - pycodestyle

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

; [url "https://gitclone.com/github.com/"]
[url "https://ghproxy.com/https://github.com/"]
	insteadOf = https://github.com
```

</details>

<details><summary> ~/.ssh/config </summary>

```shell
# $HOME/.ssh/config

Host archServer
    HostName 192.168.xx.xx
    User xxx
    Port xxx
    # AddressFamily inet # use ipv4
    # AddressFamily inet6 # use ipv6
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_rsa
    ServerAliveInterval 120
    # DynamicForward localhsot:1080
    # LocalForward localhost:5432 remote-host:5432
    # RemoteForward remote-port target-host:target-port

# 转发跳板机端口
ssh -tt -i ./id_rsa -L 0.0.0.0:local_port:host2:host2_port user@host1

# 上传公钥到目标服务器
ssh-copy-id -i ~/.ssh/id_rsa.pub archServer

# 转发服务器到本机的1082端口
ssh -D 1082 -f -C -q -N archServer

# Host github
#    HostName github.com
#    User git
#    # 走 HTTP 代理
#    # ProxyCommand socat - PROXY:127.0.0.1:%h:%p,proxyport=8080
#    # 走 socks5 代理
#    ProxyCommand nc -v -x 127.0.0.1:7890 %h %p
```

</details>

<details><summary> asdf install neovim python3 </summary>

```shell
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
. $HOME/.asdf/asdf.sh

# install neovim stable
asdf plugin add neovim
asdf install neovim stable
asdf global neovim stable

# install python3.9.14
asdf plugin add python
asdf list all python
asdf install python 3.9.14
asdf global python 3.9.14

# install nodejs 14.20.1
asdf plugin add nodejs
asdf list all nodejs
asdf install nodejs 14.20.1
asdf global nodejs 14.20.1

```

</details>

#### install

```shell
# install zsh python3-venv trash-cli neovim stylua
# if system is ubuntu/debian, use asdf install stylua
# install xclip in arch
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && sh ./installer.sh
```

#### crontab setting

```shell
# nvim /var/spool/cron/$USER
*/10 * * * * cd $HOME/.dotfiles/ && git pull
# && nvim --headless -c 'PackerSync'
```

#### questions

> 如果有报错 清除缓存

```shell
rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin
```
