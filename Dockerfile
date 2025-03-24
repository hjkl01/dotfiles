FROM archlinux:latest

# Set environment variables
ENV LANG=en_US.UTF-8
ENV TERM=xterm-256color

# Update system and install packages in a single layer to reduce image size
RUN pacman --noconfirm -Syyu && \
    pacman --noconfirm -S \
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
    lua \
    stylua \
    ripgrep \
    python3 \
    nodejs \
    npm \
    which \
    lsof \
    base-devel && \
    pacman -Scc --noconfirm && \
    rm -rf /var/cache/pacman/pkg/* && \
    echo $(which zsh) >> /etc/shells

# Clone dotfiles and set up environment in a single layer
RUN git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles /root/.dotfiles && \
    cd /root/.dotfiles && \
    cp env .env && \
    bash ./installer.sh
    

# Install Neovim plugins and language servers in a single layer
RUN nvim --headless -c 'silent Mason' -c 'sleep 5' -c 'qa!' && \
    nvim --headless \
    -c "MasonInstall python-lsp-server" \
    -c "MasonInstall bash-language-server" \
    -c "MasonInstall lua-language-server" \
    -c "MasonInstall ruff" \
    -c "MasonInstall typescript-language-server" \
    -c "MasonInstall yaml-language-server" \
    -c 'qa!'

# Create and set working directory
WORKDIR /projects

# Set default shell to zsh
SHELL ["/usr/bin/zsh", "-c"]
ENTRYPOINT ["/usr/bin/zsh"]
