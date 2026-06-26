#! /bin/sh

# brew install glib
alias rr="gio trash"

fzf_nvim() {
  if [ -n "$1" ]; then
    nvim "$@"
  else
    local file
    file=$(fd . | fzf --preview 'bat --style=numbers --color=always {}')
    [ -n "$file" ] && nvim "$file"
  fi
}

[[ -x $(command -v lsd) ]] && alias ls=lsd
[[ -x $(command -v nvim) ]] && alias vi=fzf_nvim
# [[ -x $(command -v fd) ]] && alias find=fd
[[ -x $(command -v rg) ]] && alias grep=rg

[[ -x $(command -v zoxide) ]] && eval "$(zoxide init zsh)"

alias clean_nvim='rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin'
cht() { curl cht.sh/$1; }
# curl cht.sh/rsync

export EDITOR='nvim'

# alias
alias cc='cd ~/.dotfiles'
ii() {
  local file
  file=$(fzf --height 40% --preview 'bat --style=numbers --color=always {}')
  [ -n "$file" ] && nvim "$file"
}

# find by name
# find . -name "*.log"
# grep "hello" example.txt
# grep -r "hello" my_directory

alias pc='proxychains4'
alias scpr='rsync -zvauP --exclude="logs" --exclude=".venv" --exclude="go" --exclude="node_modules" --rsh=ssh'
# alias getpass='openssl rand -base64 20'
alias getpass='openssl rand -hex 20'

# alias getip='curl ipinfo.io/ip'
# alias getip='curl -L tool.lu/ip'
# alias getip='curl http://api.ipify.org'
# alias gip='curl http://cip.cc'
alias gip='curl -s ipinfo.io'
alias gip6='curl -6 https://ifconfig.co/ip'
alias wt='curl wttr.in/nanjing'

www() {
  python -m http.server "$1" -d "$2"
}
wqr() {
  python ~/.dotfiles/config/sharefile.py "$1"
}

cdd() {
  cd $1
  ls -G
}

killport() {
    local pids

    pids=$(
        lsof -nP -i \
        | fzf \
            --multi \
            --header-lines=1 \
            --prompt="搜索端口> " \
            --with-nth=1,2,3,8,9 \
        | awk '{print $2}' \
        | sort -u
    )

    [[ -z "$pids" ]] && return

    echo "将停止以下 PID:"
    echo "$pids"

    read "ans?继续？[y/N] "

    [[ "$ans" =~ ^[Yy]$ ]] || return

    echo "$pids" | xargs kill -TERM
}

alias playradio='mpv --no-video --quiet "http://ngcdn001.cnr.cn/live/yyzs/index.m3u8"'
