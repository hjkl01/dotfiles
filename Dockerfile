FROM archlinux:latest

# Set environment variables
ENV LANG=en_US.UTF-8
ENV TERM=xterm-256color

RUN echo 'zh_CN.UTF-8\ UTF-8' >> /etc/locale.gen && locale-gen

RUN pacman --noconfirm -Syy
RUN pacman --noconfirm -Syyu
RUN pacman --noconfirm -S \
  bc \
  eza \
  bat \
  fd \
  ripgrep \
  gcc \
  openssh \
  git \
  wget \
  curl \
  tree \
  htop \
  lsof \
  ncdu \
  rsync \
  lazygit \
  zsh \
  tmux \
  fzf \
  zoxide \
  neovim \
  rust \
  lua \
  stylua \
  python3 \
  which \
  tzdata \
  base-devel && \
  pacman -Scc --noconfirm && \
  rm -rf /var/cache/pacman/pkg/* && \
  echo $(which zsh) >> /etc/shells

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

RUN git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles /root/.dotfiles && \
  cd /root/.dotfiles && cp env .env && bash ./installer.sh

# Install Neovim plugins and language servers in a single layer
RUN nvim --headless -c 'silent Mason' -c 'sleep 5' -c 'qa!'
RUN nvim --headless \
  -c "MasonInstall python-lsp-server" \
  -c "MasonInstall lua-language-server" \
  -c "MasonInstall ruff" \
  -c 'qa!'
RUN nvim --headless -c 'TSUpdate!' -c 'BlinkCmp build !' -c 'sleep 5' -c 'qa!'
RUN nvim --headless -c 'sleep 10' -c 'qa!'

WORKDIR /projects/

# Set default shell to zsh
RUN echo $(which zsh)
RUN chsh -s $(which zsh)

ENTRYPOINT ["/usr/sbin/zsh"]
