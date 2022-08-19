## dotfiles

<details><summary> config ~/.gitconfig </summary>

```shell
# ~/.gitconfig
[http "https://github.com"]
	postBuffer = 524288000
	proxy = socks5://127.0.0.1:1080
[https "https://github.com"]
	postBuffer = 524288000
	proxy = socks5://127.0.0.1:1080

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

; [url "https://ghproxy.com/https://github.com/"]
; 	insteadOf = https://github.com

; [url "https://gitclone.com/github.com/"]
; 	insteadOf = https://github.com
```

</details>

<details><summary> config ~/.ssh/config </summary>

```shell
# ~/.ssh/config
Host github
   HostName github.com
   User git
   # 走 HTTP 代理
   # ProxyCommand socat - PROXY:127.0.0.1:%h:%p,proxyport=8080
   # 走 socks5 代理
   ProxyCommand nc -v -x 127.0.0.1:1080 %h %p

Host archServer
    HostName 192.168.xx.xx
    User username
    Port 22
    # use ipv4
    AddressFamily inet
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_rsa
    ServerAliveInterval 120
    
# 转发跳板机端口
# ssh -tt -i ./id_rsa -L 0.0.0.0:local_port:host2:host2_port user@host1

# 上传共钥到目标服务器
# ssh-copy-id -i ~/.ssh/id_rsa.pub archServer

# 转发服务器到本机的1082端口
# ssh -D 1082 -f -C -q -N archServer
```

</details>

<details><summary> asdf install neovim python3 </summary>

```shell
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
. $HOME/.asdf/asdf.sh
asdf plugin add neovim python
# asdf list all python

# install neovim stable
asdf install neovim stable
asdf global neovim stable

# install python3.9
asdf install python 3.9
asdf global python 3.9
```

</details>

### install

```shell
# install git, neovim, python3-dev
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles && sh ./installer.sh
```

### crontab setting

```shell
# corntab
# nvim /var/spool/cron/$USER
*/10 * * * * cd $HOME/.dotfiles/ && git pull
*/10 * * * * cd $HOME/.dotfiles/init.lua && git pull && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
