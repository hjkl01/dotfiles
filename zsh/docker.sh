#! /bin/sh

alias dops='docker ps -a'
# stop all containers 谨慎使用
# alias dcka='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# delete null images
alias dorin='docker rmi $(docker images --filter dangling=true -q --no-trunc)'
# delete exited containers
alias dorce='docker rm -v $(docker ps -a -q -f status=exited)'
# clean null images and exited containers
# alias dclean='docker rmi -f $(docker images --filter dangling=true -q --no-trunc) && docker rm -v $(docker ps -a -q -f status=exited)'

alias dc='docker-compose'
alias doi='docker images'

# podman config
# alias dp='podman ps -a'
# alias di='podman images'
# alias dc='podman-compose'

# Select a docker container to stop and rm
dosr() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker stop | xargs -r docker rm
}

# Select a docker image or images to remove
# dori() {
#   docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
# }

dori() {
  docker images -a --format "{{.Repository}}:{{.Tag}}" | fzf-tmux -m --header="Select images to remove (Ctrl-a: select all)" | xargs -r docker rmi -f
}
