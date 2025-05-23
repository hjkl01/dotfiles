#! /bin/sh

# brew install glib
alias rr="gio trash"

[[ -x $(command -v eza) ]] && alias ls=eza
[[ -x $(command -v nvim) ]] && alias vi=nvim

alias clean_nvim='rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin'
# curl cht.sh/rsync

# export EDITOR='nvim'

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

fkill() {
  # pid=$(ps -ef | sed 1d | sk --regex -m -e -q "$1" | awk '{print $2}')
  pid=$(ps -ef | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${2:-9}"
  fi
}
