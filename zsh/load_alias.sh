#! /bin/sh

# alias_if_program_exists() {
#   local ret='0'
#   command -v $1 >/dev/null 2>&1 || { local ret='1'; }
#   # if type nvim > /dev/null 2>&1; then
#   #   alias vi='nvim'
#   # fi
#
#   # fail on non-zero return value
#   if [ "$ret" -ne 0 ]; then
#     return 1
#   fi
#
#   alias $2=$1
#   return 0
# }
#
# alias_if_program_exists trash-put rr
# alias_if_program_exists nvim vi
alias rr="trash-put"
alias vi="nvim"

# alias
alias vv='cd ~/dev'
alias cc='cd ~/.dotfiles'
alias fd='find . -name '
alias pc='proxychains4'
alias scpr='rsync -zvauP --exclude "logs" --rsh=ssh'
# alias getpass='openssl rand -base64 20'
alias getpass='openssl rand -hex 20'
alias www='ifconfig en0 && python -m http.server 80 -d $1 '
alias wqr='python ~/.dotfiles/config/sharefile.py $1'
# alias getip='curl ipinfo.io/ip'
# alias getip='curl -L tool.lu/ip'
# alias getip='curl http://api.ipify.org'
# alias gip='curl http://cip.cc'
alias gip='curl -s ipinfo.io'
alias gip6='curl -6 https://ifconfig.co/ip'
alias wt='curl wttr.in/nanjing'

# Mac proxy
alias macproxysetup='networksetup -setwebproxy Wi-Fi 127.0.0.1 8888 && networksetup -setsecurewebproxy Wi-Fi 127.0.0.1 8888 && networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 8888'
alias macproxystart='networksetup -setwebproxystate Wi-Fi on && networksetup -setsecurewebproxystate Wi-Fi on && networksetup -setsocksfirewallproxystate Wi-Fi on'
alias macproxystop='networksetup -setwebproxystate Wi-Fi off && networksetup -setsecurewebproxystate Wi-Fi off && networksetup -setsocksfirewallproxystate Wi-Fi off'

# vultr
export VULTR_API_KEY=''
alias vc='vultr-cli'
