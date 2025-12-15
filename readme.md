# 我的 Dotfiles (My Dotfiles)

这是我的个人配置文件集合，用于统一我在不同设备上的开发环境，主要围绕 Zsh、Neovim、Tmux 和 Ghostty。

<!-- 💡 在这里插入一张截图或 GIF 来展示你的终端和编辑器外观！ -->

## 目录

- [🚀 快速开始](#-快速开始)
- [💡 推荐工具](#-推荐工具)
- [🔧 配置与使用](#-配置与使用)
- [🤔 故障排除](#-故障排除)
- [🙏 致谢](#-致谢)

---

## 📁 包含配置

本仓库包含以下工具的配置文件：

- **Zsh**: 增强的 Shell 配置，包括别名、插件和主题
- **Neovim**: 基于 LazyVim 的现代化编辑器配置
- **Tmux**: 终端复用器配置，支持插件管理
- **Ghostty**: 现代终端模拟器配置
- **Alacritty**: 轻量级终端模拟器配置
- **Rime**: 中文输入法配置
- **其他**: Git、Python、Docker 等工具配置

---

## 🚀 快速开始

### 1. 环境准备 (Prerequisites)

在开始之前，请确保你的系统已经安装了以下核心工具，这些是保证配置正常运行所必需的。

-   **核心依赖**:
    -   `git`: 版本控制工具。
    -   `zsh`: 功能强大的 Shell。
    -   `neovim`: 可扩展的现代化文本编辑器。
    -   `tmux`: 终端复用器。
    -   `asdf`: 多版本管理工具，用于管理 `python`, `node` 等。
-   **Neovim 依赖**:
    -   `ripgrep`: 用于代码搜索。
    -   `fzf`: 模糊搜索工具。
    -   `stylua`: Lua 代码格式化工具。
-   **剪贴板工具**:
    -   **Linux (X11)**: `xclip` 或 `xsel`。
    -   **WSL**: `win32yank.exe` (需要手动下载并放置到 PATH)。
-   **输入法 (可选)**:
    -   `fcitx5-rime`: 用于中文输入。

### 2. 安装

使用以下步骤来安装 dotfiles。

```shell
# 步骤 1: (可选) 配置 GitHub 镜像以加速下载
# 如果你访问 GitHub 速度较慢，可以执行此命令
git config --global url."https://gh.hjkl01.cn/https://github.com".insteadOf "https://github.com"

# 步骤 2: 克隆仓库到本地
git clone https://github.com/hjkl01/dotfiles ~/.dotfiles
cd ~/.dotfiles

# 步骤 3: 运行安装脚本来链接配置文件
# 这将会把仓库中的配置文件软链接到你的 Home 目录下
bash ./installer.sh link

# 步骤 4: 更改默认 Shell 为 Zsh
chsh -s $(which zsh)
```

> **注意**: 脚本执行后，请重新启动终端或 `source ~/.zshrc` 来使配置生效。

---

## 💡 推荐工具

以下是一些我个人喜欢并推荐的命令行工具，它们能极大提升你的终端体验，但并非必需。

-   `lsd`: 现代化的 `ls` 命令，带图标和颜色。
-   `zoxide`: 更智能的目录跳转工具，替代 `cd`。
-   `fd`: 简单、快速、友好的 `find` 替代品。
-   `git-delta`: `git diff` 的美化工具。
-   `lazygit`: TUI 界面的 Git 客户端，非常高效。
-   `yazi` / `superfile`: 现代化的 TUI 文件管理器。
-   `dust`: 查看目录大小，`du` 的友好替代品。
-   `tree`: 以树状结构显示文件。
-   `broot`: 交互式目录树导航。
-   `htop`: 交互式进程查看器。
-   `ncdu`: 磁盘使用分析器。
-   `proxychains-ng`: 终端网络代理工具。

---

## 🔧 配置与使用

### Rime 输入法 (`fcitx5-rime`)

我使用 `rime-auto-deploy` 项目来自动化部署 Rime 的词库和配置。

```shell
# sudo pacman -S fcitx5 fcitx5-rime fcitx5-configtool fcitx5-gtk fcitx5-qt 

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

### asdf 环境加速

对于 `asdf` 管理的语言（如 Python），可以通过设置环境变量来使用镜像源，从而加速下载。

**以 Python 为例:**

将以下行添加到你的 `~/.zshrc` 或 `~/.bashrc` 文件中，可以显著提高 `asdf install python ...` 的速度。

```shell
# 使用镜像源加速 asdf-python 的下载
export PYTHON_BUILD_MIRROR_URL="https://registry.npmmirror.com/-/binary/python"
```

这种方法比手动修改插件文件更推荐，因为它不会在插件更新后被覆盖。

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

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这些配置！

如果你有更好的配置建议或发现了问题，请随时联系。

---

## 🙏 致谢

这份配置的灵感和部分代码来源于以下优秀的开源项目：

-   [NvChad](https://github.com/NvChad/NvChad)
-   [LazyVim](https://github.com/LazyVim/LazyVim)

---

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。