# My Dotfiles

这是我的个人配置文件集合，用于统一我在不同设备上的开发环境，主要围绕 Zsh、Neovim、Tmux 和 Ghostty。

---

## 🚀 快速开始

### 1. 环境准备 (Prerequisites)

在开始之前，请确保你的系统已经安装了以下基础工具：

-   **核心工具**: `git`, `zsh`, `tmux`, `fzf`, `zoxide`, `neovim`
-   **Neovim 依赖**: `ripgrep` (用于搜索), `stylua` (Lua 格式化)
-   **剪贴板工具**:
    -   **Linux (X11)**: `xclip`
    -   **WSL**: `win32yank.exe` (需要手动下载并放置到 PATH)
-   **输入法 (可选)**: `fcitx5-rime`

> **提示**: 在 Ubuntu/Debian 等系统上，如果 `apt` 源的版本过旧，建议使用 `asdf` 来安装 `stylua`。

#### 🐳 Docker 容器中体验

```
docker run -ti --rm -v $(pwd):/projects formattedd/dotfiles zsh
```

### 2. 一键安装

使用以下命令下载并执行安装脚本。

```shell
curl -fsSL https://gh.hjkl01.cn/https://raw.githubusercontent.com/hjkl01/dotfiles/refs/heads/master/installer.sh -o install.sh && chmod +x install.sh && bash ./install.sh
```

-   默认情况下，脚本会备份你现有的配置文件（如 `~/.zshrc`）并创建新的符号链接。
-   如果你只想创建链接而不进行其他设置（如配置镜像源），可以运行 `bash ./install.sh link`。

安装完成后，将 Zsh 设置为你的默认 Shell：

```shell
chsh -s $(which zsh)
```

---

## 🔧 配置与使用

### Git 代理设置

如果在中国大陆访问 GitHub 速度较慢，可以配置代理来加速 `git clone`。

```shell
# 配置 git 代理
git config --global url."https://gh.hjkl01.cn/proxy/https://github.com".insteadOf "https://github.com"

# 取消代理
git config --global --unset url."https://gh.hjkl01.cn/proxy/https://github.com".insteadOf
```

### Rime 输入法 (`fcitx5-rime`)

我使用 `rime-auto-deploy` 项目来自动化部署 Rime 的词库和配置。

```shell
# 1. 克隆部署工具
git clone --depth=1 https://github.com/Mark24Code/rime-auto-deploy
cd rime-auto-deploy

# 2. 运行安装器 (需要 Ruby 环境)
./installer.rb

# 3. (可选) 配置 fcitx5 环境变量
# 将以下内容添加到 /etc/environment 或 ~/.profile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# 4. 在 macOS 上重载 Squirrel (Rime)
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
```

### Tmux 插件管理

Tmux 的插件使用 `tpm` 管理。

-   **安装插件**: `prefix + I` (大写 I)
-   **更新插件**: `prefix + U`

### Crontab 自动更新

你可以设置一个定时任务，每天自动更新 dotfiles 仓库。

```cron
# 使用 crontab -e 编辑定时任务
# 每天早上 8:50 自动拉取最新配置
50 8 * * * git -C $HOME/.dotfiles pull
```

---

## 🤔 故障排除

### Neovim 报错或缓存问题

如果 Neovim 启动时出现错误，通常是缓存或插件问题。可以尝试清除缓存：

```shell
rm -rf ~/.local/share/nvim/ ~/.cache/nvim
```
然后重启 Neovim，让 `lazy.nvim` 重新同步插件。

### WSL 与 Windows 剪贴板集成

-   确保你已经下载了 `win32yank.exe` 并将其放在了 WSL 可以访问到的 PATH 路径下。
-   Windows Terminal 或 Alacritty for Windows 的配置文件路径通常在: `~/AppData/Roaming/alacritty/alacritty.toml`。

---

## 💡 推荐工具

一些我喜欢并推荐的命令行工具：

-   `tree`: 以树状图列出文件和目录。
-   `htop`: 交互式的进程查看器。
-   `lsof`: 列出打开的文件。
-   `ncdu`: 磁盘空间使用分析器。
-   `rsync`: 强大的文件同步工具。
-   `proxychains-ng`: 终端网络代理工具。
-   `lazygit`: TUI 形式的 Git 客户端。
-   [yazi](https://github.com/sxyazi/yazi): 一个用 Rust 编写的极速终端文件管理器。
-   [superfile](https://github.com/yorukot/superfile): 一款 Go 编写的现代化 TUI 文件管理器。

---

## 🙏 致谢

这份配置的灵感和部分代码来源于以下优秀的开源项目：

-   [NvChad](https://github.com/NvChad/NvChad)
-   [LazyVim](https://github.com/LazyVim/LazyVim)
