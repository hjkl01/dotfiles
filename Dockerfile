FROM archlinux:latest

RUN pacman --noconfirm -Syy
RUN pacman --noconfirm -S gcc openssh git wget curl tree htop lsof ncdu rsync lazygit zsh tmux fzf zoxide neovim \
                          lua stylua ripgrep python3 nodejs npm which lsof
RUN echo $(which zsh) >> /etc/shells

RUN git clone --single-branch --depth=1 https://github.com/hjkl01/dotfiles /root/.dotfiles && \
    cd /root/.dotfiles && cp env .env && \
    sed -i 's|execute_function Installasdf||g' installer.sh && \
    bash ./installer.sh && \
    echo 'export ZSH_ENV="docker container "' >> /root/.dotfiles/.env

RUN nvim \
    --headless \
    -c 'silent Mason ' \
    -c 'sleep 5' \
    -c 'qa!'

RUN nvim --headless \
    -c "MasonInstall python-lsp-server " \
    -c "MasonInstall bash-language-server" \
    -c "MasonInstall lua-language-server" \
    -c "MasonInstall ruff" \
    -c "MasonInstall typescript-language-server" \
    -c 'qa!'

RUN nvim --headless -c 'lua print(vim.inspect(require("mason-registry").get_installed_packages()))' -c 'qa!'

CMD ['zsh']
