#! /bin/sh

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
# alias gg='GO111MODULE=on go get'
# alias gr='GO111MODULE=on go run'
