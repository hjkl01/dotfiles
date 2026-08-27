FROM archlinux:latest

# Set environment variables
ENV LANG=zh_CN.UTF-8
ENV TERM=xterm-256color

RUN echo 'zh_CN.UTF-8\ UTF-8' >> /etc/locale.gen && locale-gen

# 合并包安装、时区设置、dotfiles 克隆到单层 RUN，减少镜像层数
RUN pacman --noconfirm -Syy &&   pacman --noconfirm -S   bc   eza   bat   fd   ripgrep   gcc   openssh   git   wget   curl   tree   htop   lsof   ncdu   rsync   lazygit   zsh   tmux   fzf   zoxide   neovim   rust   lua   stylua   python3   which   tzdata   base-devel &&   pacman -Scc --noconfirm &&   rm -rf /var/cache/pacman/pkg/* &&   echo $(which zsh) >> /etc/shells &&   ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&   git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles /root/.dotfiles &&   cd /root/.dotfiles && cp env .env && bash ./installer.sh

# 合并 Neovim 插件和 LSP 安装到单层 RUN
# 使用 --headless + quit 模式，避免不稳定的 sleep
RUN nvim --headless   -c 'lua vim.pack.update()'   -c 'sleep 5'   -c 'qa!' &&   nvim --headless   -c 'silent Mason'   -c 'sleep 3'   -c 'qa!' &&   nvim --headless   -c "MasonInstall python-lsp-server lua-language-server ruff"   -c 'sleep 3'   -c 'qa!' &&   nvim --headless   -c 'TSUpdate'   -c 'sleep 3'   -c 'qa!' &&   nvim --headless   -c 'BlinkCmp build !'   -c 'sleep 3'   -c 'qa!'

WORKDIR /projects/

# Set default shell to zsh
RUN chsh -s $(which zsh)

ENTRYPOINT ["/usr/sbin/zsh"]
