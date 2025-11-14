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

[[ -x $(command -v eza) ]] && alias ls=eza
[[ -x $(command -v nvim) ]] && alias vi=fzf_nvim
# [[ -x $(command -v fd) ]] && alias find=fd
[[ -x $(command -v rg) ]] && alias grep=rg

[[ -x $(command -v lsof) ]] && alias lsof="lsof -i -P -n | fzf"
[[ -x $(command -v zoxide) ]] && eval "$(zoxide init zsh)"

alias clean_nvim='rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin'
cht() { curl cht.sh/$1; }
# curl cht.sh/rsync

export EDITOR='nvim'

# alias
alias cc='cd ~/.dotfiles'
alias ii='vi $(fzf --height 40%)'

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
