#! /bin/sh

# install chsrc to use mirrors

# python config
virtualenv_path=~/.venv/py3/bin/activate
if [ -f $virtualenv_path ]; then
  source $virtualenv_path
fi

# pip install better_exceptions
export BETTER_EXCEPTIONS=1

# .venv
alias pr='.venv/bin/python'
alias pi='.venv/bin/pip'

export GOPROXY=https://goproxy.cn
export GO111MODULE=auto
export GOPATH=$HOME/dev/go
export PATH=$HOME/dev/go/bin:$HOME/.cargo/bin:$HOME/.local/share/nvim/mason/bin:$PATH
