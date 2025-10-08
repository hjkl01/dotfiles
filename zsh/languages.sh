#! /bin/sh

# install chsrc to use mirrors

# python config

virtualenv_path=~/.venv/py3/bin/activate
if [ -f $virtualenv_path ]; then
  source $virtualenv_path
fi

# pip install better_exceptions
export BETTER_EXCEPTIONS=1

# flask
# export FLASK_APP=app.py
# export FLASK_ENV=development

# export PIPENV_IGNORE_VIRTUALENVS=1
# export PIPENV_VERBOSITY=-1
# alias pr='pipenv run python'
# alias pi='pipenv run pip install '

# alias pr='poetry run python'
# alias pi='poetry run pip install'

# pdm
# alias pr='pdm run'
# alias pi='pdm run pip install'

# .venv
alias pr='.venv/bin/python'
alias pi='.venv/bin/pip'

# golang config

# Go语言中文网
# https://studygolang.com/dl
# Aliyun
# https://mirrors.aliyun.com/golang/
# export GOPROXY=https://mirrors.aliyun.com/goproxy/
# Proxy-io
# https://gomirrors.org/
# 中科大
# https://mirrors.ustc.edu.cn/golang/

export GOPROXY=https://goproxy.cn
export GO111MODULE=auto
export GOPATH=$HOME/dev/go
export PATH="$PATH:$HOME/dev/go/bin"

# rust config
export PATH="$PATH:$HOME/.cargo/bin/"

# neovim mason path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
