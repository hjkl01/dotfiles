#### my workspace config

> install git, make, neovim, python3

```
github: 
  git clone https://github.com/lesssound/dotfiles ~/.dotfiles
gitee: 
  git clone https://gitee.com/lesssound/dotfiles.git ~/.dotfiles

cd ~/.dotfiles 
make github or make gitee
```

<details>
  <summary>
    git
  </summary>

##### public key
``` shell
git config --global user.name ""
git config --global user.email ""
ssh-keygen -t rsa -b 4096 -C ""
```

##### git config
``` shell
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080
git config --global https.https://github.com.proxy socks5://127.0.0.1:1080

or

# ~/.gitconfig
[http "https://github.com"]
proxy = socks5://127.0.0.1:1080
postBuffer = 524288000
[https "https://github.com"]
proxy = socks5://127.0.0.1:1080
postBuffer = 524288000

```
</details>
