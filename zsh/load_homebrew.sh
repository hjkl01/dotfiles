# 安装
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# # 从本镜像下载安装脚本并安装 Homebrew / Linuxbrew
# git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
# /bin/bash brew-install/install.sh
# rm -rf brew-install
#
# # 也可从 GitHub 获取官方安装脚本安装 Homebrew / Linuxbrew
# /bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/master/install.sh)"


# 替换现有仓库上游
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
#     brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
# done
# brew update

# 复原仓库上游
# # brew 程序本身，Homebrew / Linuxbrew 相同
# unset HOMEBREW_BREW_GIT_REMOTE
# git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew
#
# # 以下针对 macOS 系统上的 Homebrew
# unset HOMEBREW_CORE_GIT_REMOTE
# BREW_TAPS="$(BREW_TAPS="$(brew tap 2>/dev/null)"; echo -n "${BREW_TAPS//$'\n'/:}")"
# for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
#     if [[ ":${BREW_TAPS}:" == *":homebrew/${tap}:"* ]]; then  # 只复原已安装的 Tap
#         brew tap --custom-remote "homebrew/${tap}" "https://github.com/Homebrew/homebrew-${tap}"
#     fi
# done
#
# brew update
