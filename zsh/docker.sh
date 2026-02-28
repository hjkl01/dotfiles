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


drun() {
  local image
  image=$(docker images --format "{{.Repository}}:{{.Tag}}" | \
    fzf --layout=reverse --prompt="选择镜像运行 > ")

  [[ -z "$image" ]] && return

  docker run -it --rm "$image" /bin/bash 2>/dev/null || \
  docker run -it --rmn "$image" /bin/sh
}

dnetclean() {
  docker network ls --format "{{.Name}}|{{.ID}}" | \
  fzf --multi --layout=reverse | \
  cut -d'|' -f2 | xargs docker network rm
}

dvolclean() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf 未安装"
    return 1
  fi

  local volumes
  volumes=$(docker volume ls --format "{{.Name}}|{{.Driver}}" | sort)

  [[ -z "$volumes" ]] && { echo "没有 volume"; return 0; }

  local selected
  selected=$(echo "$volumes" | \
    fzf --multi \
        --layout=reverse \
        --cycle \
        --prompt="选择要删除的 Docker Volumes > " \
        --header="Name | Driver" \
        --preview='
          name=$(echo {} | cut -d"|" -f1)
          echo "===== Volume Inspect ====="
          docker volume inspect "$name" 2>/dev/null
          echo
          echo "===== Used By Containers ====="
          docker ps -a --filter volume="$name" \
            --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
        ' \
        --preview-window=right:60%)

  [[ -z "$selected" ]] && return 0

  local volume_names
  volume_names=$(echo "$selected" | cut -d'|' -f1)

  echo "即将删除以下 Volumes："
  echo "$volume_names"
  echo

  read "confirm?确认删除？(y/N): "

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$volume_names" | xargs docker volume rm
    echo "删除完成"
  else
    echo "已取消"
  fi
}

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
  # local container=$(docker ps --format "{{.Names}}" | fzf --header="Select container")
  # [ -n "$container" ] && docker exec -it "$container" sh
  local cid
  cid=$(docker ps --format "{{.Names}}|{{.ID}}|{{.Image}}" | \
    fzf --layout=reverse --prompt="选择容器进入 > " | cut -d'|' -f2)

  [[ -z "$cid" ]] && return

  docker exec -it "$cid" /bin/bash 2>/dev/null || \
  docker exec -it "$cid" /bin/sh
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

dfzf() {
  local action
  action=$(printf "Containers\nImages\nVolumes\nNetworks\nSystem Clean\n" | \
    fzf --layout=reverse --prompt="Docker Manager > ")

  case "$action" in

  ######################################################################
  # CONTAINERS
  ######################################################################
  "Containers")
    local container
    container=$(docker ps -a --format "{{.Names}}|{{.ID}}|{{.Status}}|{{.Image}}" | \
      awk -F'|' '
      {
        status=$3
        color="\033[34m"
        if (status ~ /^Up/) color="\033[32m"
        else if (status ~ /^Exited/ || status ~ /^Dead/) color="\033[31m"
        else if (status ~ /^Paused/) color="\033[33m"

        printf "%s%s\033[0m|%s|%s|%s\n", color, $1, $2, $3, $4
      }' | \
      fzf --multi --ansi --layout=reverse --cycle \
          --header="Name(color by status) | ID | Status | Image" \
          --preview='echo {} | sed "s/\x1b\[[0-9;]*m//g" | cut -d"|" -f2 | xargs docker inspect 2>/dev/null' \
          --preview-window=right:60%)

    [[ -z "$container" ]] && return
    local ids
    ids=$(echo "$container" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'|' -f2)

    local op
    op=$(printf "exec\nlogs\ndelete\nstart\nstop\n" | \
      fzf --layout=reverse --prompt="Containers Action > ")

    case "$op" in
      exec)
        first_id=$(echo "$ids" | head -n1)
        docker exec -it "$first_id" /bin/bash 2>/dev/null || \
        docker exec -it "$first_id" /bin/sh
        ;;
      logs)
        first_id=$(echo "$ids" | head -n1)
        docker logs -f "$first_id"
        ;;
      delete)
        echo "$ids" | xargs docker rm -f
        ;;
      start)
        echo "$ids" | xargs docker start
        ;;
      stop)
        echo "$ids" | xargs docker stop
        ;;
    esac

    ;;

  ######################################################################
  # IMAGES
  ######################################################################
  "Images")
    local image
    image=$(docker images --format "{{.Repository}}:{{.Tag}}|{{.ID}}|{{.Size}}" | \
      awk -F'|' '
      {
        name=$1
        color="\033[36m"
        if (name ~ /<none>/) color="\033[31m"
        printf "%s%s\033[0m|%s|%s\n", color, $1, $2, $3
      }' | \
      fzf --multi --ansi --layout=reverse --cycle \
          --header="Image(color: dangling=red) | ID | Size" \
          --preview='echo {} | sed "s/\x1b\[[0-9;]*m//g" | cut -d"|" -f2 | xargs docker image inspect 2>/dev/null' \
          --preview-window=right:60%)

    [[ -z "$image" ]] && return
    local ids
    ids=$(echo "$image" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'|' -f2)

    local op
    op=$(printf "run\ndelete\n" | \
      fzf --layout=reverse --prompt="Images Action > ")

    case "$op" in
      run)    echo "$ids" | head -n1 | xargs -I{} docker run -it --rm {} /bin/bash ;;
      delete) echo "$ids" | xargs docker rmi ;;
    esac
    ;;

  ######################################################################
  # VOLUMES
  ######################################################################
  "Volumes")
    local volume
    volume=$(docker volume ls --format "{{.Name}}|{{.Driver}}" | \
      awk -F'|' '
      {
        color="\033[35m"
        printf "%s%s\033[0m|%s\n", color, $1, $2
      }' | \
      fzf --multi --ansi --layout=reverse --cycle \
          --header="Volume | Driver" \
          --preview='
            clean=$(echo {} | sed "s/\x1b\[[0-9;]*m//g")
            name=$(echo $clean | cut -d"|" -f1)
            echo "===== Inspect ====="
            docker volume inspect "$name"
            echo
            echo "===== Used By ====="
            docker ps -a --filter volume="$name" \
              --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
          ' \
          --preview-window=right:60%)

    [[ -z "$volume" ]] && return
    echo "$volume" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'|' -f1 | xargs docker volume rm
    ;;

  ######################################################################
  # NETWORKS
  ######################################################################
  "Networks")
    local net
    net=$(docker network ls --format "{{.Name}}|{{.Driver}}" | \
      awk -F'|' '
      {
        color="\033[33m"
        if ($1 == "bridge" || $1 == "host" || $1 == "none")
          color="\033[31m"
        printf "%s%s\033[0m|%s\n", color, $1, $2
      }' | \
      fzf --multi --ansi --layout=reverse --cycle \
          --header="Network(red=system default) | Driver" \
          --preview='
            clean=$(echo {} | sed "s/\x1b\[[0-9;]*m//g")
            name=$(echo $clean | cut -d"|" -f1)
            docker network inspect "$name"
          ' \
          --preview-window=right:60%)

    [[ -z "$net" ]] && return
    echo "$net" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'|' -f1 | xargs docker network rm
    ;;

  ######################################################################
  # SYSTEM CLEAN
  ######################################################################
  "System Clean")
    docker system df
    echo
    read "confirm?执行 docker system prune -a ? (y/N): "
    [[ "$confirm" =~ ^[Yy]$ ]] && docker system prune -a
    ;;
  esac
}
