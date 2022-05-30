alias_if_program_exists() {
  local ret='0'
  command -v $1 >/dev/null 2>&1 || { local ret='1'; }
  # if type nvim > /dev/null 2>&1; then
  #   alias vi='nvim'
  # fi

  # fail on non-zero return value
  if [ "$ret" -ne 0 ]; then
    return 1
  fi

  alias $2=$1
  return 0
}

if [ -f ~/.venv/py3/bin/activate ];then
  source ~/.venv/py3/bin/activate
fi

alias_if_program_exists trash-put rr
alias_if_program_exists nvim vi


# alias
alias pc='proxychains4'
alias scpr='rsync -Pzv --exclude "logs" --rsh=ssh'
# alias getpass='openssl rand -base64 20'
alias getpass='openssl rand -hex 20'
alias www='ifconfig en0 && python -m http.server 80 -d $1 '
# alias getip='curl ipinfo.io/ip'
# alias getip='curl -L tool.lu/ip'
# alias getip='curl http://api.ipify.org'
alias getip='curl http://cip.cc'
alias wt='curl wttr.in/nanjing'


export PROXY_URL="socks5://127.0.0.1:1080"
export PROXY_URL="http://127.0.0.1:7890"
alias setproxy='export ALL_PROXY=$PROXY_URL'
alias unsetproxy='unset ALL_PROXY; unset http_proxy; unset https_proxy'

run_cmd(){
  export ALL_PROXY=$PROXY_URL
  $*
  unset ALL_PROXY; unset http_proxy; unset https_proxy
}
alias px=run_cmd $*

# asdf
# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
# asdf list all nodejs

# python config
# pip install better_exceptions
export BETTER_EXCEPTIONS=1
# export FLASK_APP=app.py
# export FLASK_ENV=development

export PIPENV_IGNORE_VIRTUALENVS=1
export PIPENV_VERBOSITY=-1
alias pv='pipenv run python'
alias pi='pipenv run pip install '

# alias pv='poetry run python'
# alias pi='poetry run pip install'

# yarn config
alias yy='yarn'
alias ys='yarn start'


# git config
alias gc='git clone'
alias gs='git status'
alias ga='git add'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'


# golang config
# export GOPROXY=https://mirrors.aliyun.com/goproxy/
# export GOPROXY=https://goproxy.cn
# export GO111MODULE=auto
# export GOPATH=$HOME/dev/go
# export PATH="$PATH:$HOME/dev/go/bin"
# alias gg='GO111MODULE=on go get'
# alias gr='GO111MODULE=on go run'


# docker config
alias dp='docker ps -a'
# stop all containers 谨慎使用
alias dk='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# delete null images
alias dr='docker rmi $(docker images --filter dangling=true -q --no-trunc)'
# delete exited containers
alias dre='docker rm -v $(docker ps -a -q -f status=exited)'
alias dc='docker-compose'
alias di='docker images'
alias dir='docker rmi'

# git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
# git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
# git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask
# brew update

# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
#     brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
# done
# brew update
