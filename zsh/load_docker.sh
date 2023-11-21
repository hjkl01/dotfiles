#! /bin/sh

# docker config

# /etc/docker/daemon.json
# {"registry-mirrors":["https://reg-mirror.qiniu.com/"]}

# https://hub-mirror.c.163.com
# https://mirror.baidubce.com

alias dp='docker ps -a'
# stop all containers 谨慎使用
alias dkkkk='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# delete null images
alias dr='docker rmi $(docker images --filter dangling=true -q --no-trunc)'
# delete exited containers
alias dre='docker rm -v $(docker ps -a -q -f status=exited)'
alias dc='docker-compose'
alias di='docker images'
alias dir='docker rmi'

# podman config
# alias dp='podman ps -a'
# alias di='podman images'
# alias dc='podman-compose'
