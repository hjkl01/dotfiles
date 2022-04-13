## my workspace config

###
{% codeblock "config ~/.gitconfig and ~/.ssh/config" lang:sh >folded %}
# ~/.gitconfig
[http "https://github.com"]
	postBuffer = 524288000
	proxy = socks5://127.0.0.1:1080
	; insteadOf = https://hub.fastgit.org
	; insteadOf = https://gitclone.com/github.com
	; insteadOf = https://github.com.cnpmjs.org
[https "https://github.com"]
	postBuffer = 524288000
	proxy = socks5://127.0.0.1:1080
	; insteadOf = https://hub.fastgit.org
	; insteadOf = https://gitclone.com/github.com
	; insteadOf = https://github.com.cnpmjs.org

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
    User xxx
    Port xxx
    # use ipv4
    # AddressFamily inet
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_rsa
    ServerAliveInterval 120
    
# 转发跳板机端口
# ssh -tt -i ./id_rsa -L 0.0.0.0:local_port:host2:host2_port user@host1

# 上传共钥到目标服务器
# ssh-copy-id -i ~/.ssh/id_rsa.pub archServer

# 转发服务器到本机的1082端口
# ssh -D 1082 -f -C -q -N archServer
{% endcodeblock %}

```
# install git, neovim, python3-dev
  git clone https://github.com/lesssound/dotfiles ~/.dotfiles
  cd ~/.dotfiles && sh ./installer.sh
```
