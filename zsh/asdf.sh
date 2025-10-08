#! /bin/sh

# asdf
# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

asdf_completions_path=${ASDF_DATA_DIR:-$HOME/.asdf}/completions
if [ -f $asdf_completions_path ]; then
	mkdir -p $asdf_completions_path
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
fi

# 添加补全功能到 fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# 使用 ZSH 的 compinit 初始化补全功能
autoload -Uz compinit && compinit
