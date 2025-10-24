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

# fkill() {
#   # pid=$(ps -ef | sed 1d | sk --regex -m -e -q "$1" | awk '{print $2}')
#   pid=$(ps -ef | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{print $2}')
#
#   if [ "x$pid" != "x" ]; then
#     echo "$pid" | xargs kill -"${2:-9}"
#   fi
# }

fkill() {
  ps -ef | fzf -m --header="选择多个进程 (Tab键多选)" | awk '{print $2}' | xargs -r kill -9
}

# 上传本地文件到远程主机
scpu() {
  local host
  host=$(rg '^Host\s+(.*)' ~/.ssh/config --no-heading | awk '{print $2}' | fzf --prompt="选择远程主机: ")
  [ -z "$host" ] && echo "❌ 未选择主机" && return 1

  # 选择本地文件/目录（可多选）
  local targets
  targets=$(fd . --type f --type d | fzf --multi --prompt="选择要上传的本地文件/目录: " --preview 'if [[ -d {} ]]; then ls -la {}; else file {}; fi')
  [ -z "$targets" ] && echo "❌ 未选择文件/目录" && return 1

  # 输入远程目录（默认为远程用户主目录）
  local remote_dir
  echo -n "📁 请输入远程目录路径 [默认: home directory]: "
  read remote_dir
  remote_dir=${remote_dir:-.}  # Use . to mean remote user's home directory

  echo "🚀 上传中: $(echo $targets | tr '\n' ' ') → $host:$remote_dir"
  
  # Process each target individually to avoid path issues
  local target
  while IFS= read -r target; do
    if [ -n "$target" ]; then
        # rsync -avzP --exclude="logs" --exclude=".venv" --exclude="go" --exclude="node_modules" --rsh=ssh "$target" "${host}:${remote_dir}/"
        scpr "$target" "${host}:${remote_dir}/"
    fi
  done <<< "$targets"
}

scpd() {
  local host
  host=$(rg '^Host\s+(.*)' ~/.ssh/config --no-heading | awk '{print $2}' | fzf --prompt="选择远程主机: ")
  [ -z "$host" ] && echo "❌ 未选择主机" && return 1

  # 在远程主机上用 fd 查找非隐藏文件（~目录下）
  local file
  file=$(ssh "$host" 'fd . --hidden --max-depth 2 ~' | fzf --prompt="选择要下载的远程文件: " --preview "ssh '"$host"' ls -lh {}")
  [ -z "$file" ] && echo "❌ 未选择文件" && return 1

  # 输入本地保存目录（默认当前目录）
  local local_dir
  echo -n "📂 请输入本地保存目录 [默认: 当前目录]: "
  read local_dir
  local_dir=${local_dir:-.}

  echo "⬇️ 正在下载: $host:$file → $local_dir"
  # rsync -avzP "${host}:$file" "$local_dir"
  scpr "${host}:$file" "$local_dir"
}
