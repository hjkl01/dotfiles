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

# alias dc='docker-compose'
alias dc='docker compose'
alias doi='docker images'

# podman config
# alias dp='podman ps -a'
# alias di='podman images'
# alias dc='podman-compose'

dlog() {
  local container_id
  container_id=$(docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}" |
    fzf --header-lines=1 --preview 'docker logs {1}' --preview-window=right:60% |
    awk '{print $1}')
  if [ -n "$container_id" ]; then
    docker logs -f --tail 200 "$container_id"
  else
    echo "未选择容器"
  fi
}

dexec() {
  local container=$(docker ps --format "{{.Names}}" | fzf --header="Select container")
  [ -n "$container" ] && docker exec -it "$container" sh
}

dlz() {
  docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock lazyteam/lazydocker
}


# docker image 多选删除
docker-image-clean() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf 未安装"
    return 1
  fi

  local images
  images=$(docker images --format "{{.Repository}}:{{.Tag}}|{{.ID}}|{{.Size}}" | sort)

  if [[ -z "$images" ]]; then
    echo "没有可用的 docker images"
    return 0
  fi

  local selected
  selected=$(echo "$images" | \
    fzf --multi \
        --layout=reverse \
        --prompt="选择要删除的 Docker Images (Tab 多选) > " \
        --header="Repository:Tag | ImageID | Size" \
        --preview="echo {} | cut -d'|' -f2 | xargs docker image inspect 2>/dev/null" \
        --preview-window=right:60%)

  [[ -z "$selected" ]] && return 0

  local image_ids
  image_ids=$(echo "$selected" | cut -d'|' -f2)

  echo "即将删除以下镜像："
  echo "$selected"
  echo

  read "confirm?确认删除？(y/N): "

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$image_ids" | xargs docker rmi
    echo "删除完成"
  else
    echo "已取消"
  fi
}

alias dori='docker-image-clean'


# docker container 多选删除
docker-container-clean() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf 未安装"
    return 1
  fi

  local containers
  containers=$(docker ps -a --format "{{.Names}}|{{.ID}}|{{.Status}}|{{.Image}}" | sort)

  if [[ -z "$containers" ]]; then
    echo "没有可用的 docker containers"
    return 0
  fi

  local selected
  selected=$(echo "$containers" | \
    fzf --multi \
        --layout=reverse \
        --cycle \
        --prompt="选择要删除的 Docker Containers (Tab 多选) > " \
        --header="Name | ID | Status | Image" \
        --preview="echo {} | cut -d'|' -f2 | xargs docker inspect 2>/dev/null" \
        --preview-window=right:60%)

  [[ -z "$selected" ]] && return 0

  local container_ids
  container_ids=$(echo "$selected" | cut -d'|' -f2)

  echo "即将删除以下容器："
  echo "$selected"
  echo

  read "confirm?确认删除？(y/N): "

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    # 自动停止运行中的容器
    echo "$container_ids" | xargs docker rm -f
    echo "删除完成"
  else
    echo "已取消"
  fi
}

alias dosrc='docker-container-clean'
