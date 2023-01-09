#! /bin/sh

# proxy config

export P_ADDRESS="127.0.0.1"
export P_PORT="7890"
export PROXY_URL="http://$P_ADDRESS:$P_PORT"

alias setproxy='export ALL_PROXY=$PROXY_URL'
alias unsetproxy='unset ALL_PROXY; unset http_proxy; unset https_proxy'

run_cmd() {
  export ALL_PROXY=$PROXY_URL
  $*
  unset ALL_PROXY
  unset http_proxy
  unset https_proxy
}
alias px=run_cmd $*

# Mac proxy
alias macproxysetup='networksetup -setwebproxy Wi-Fi $P_ADDRESS $P_PORT && networksetup -setsecurewebproxy Wi-Fi $P_ADDRESS $P_PORT && networksetup -setsocksfirewallproxy Wi-Fi $P_ADDRESS $P_PORT'
alias macproxystart='networksetup -setwebproxystate Wi-Fi on && networksetup -setsecurewebproxystate Wi-Fi on && networksetup -setsocksfirewallproxystate Wi-Fi on'
alias macproxystop='networksetup -setwebproxystate Wi-Fi off && networksetup -setsecurewebproxystate Wi-Fi off && networksetup -setsocksfirewallproxystate Wi-Fi off'
