#! /bin/sh

# proxy config

export PROXY_URL="http://$P_ADDRESS:$P_PORT"

alias setproxy='export HTTP_PROXY=$PROXY_URL; export HTTPS_PROXY=$PROXY_URL; export ALL_PROXY=$PROXY_URL;'
alias unsetproxy='unset HTTP_PROXY; unset HTTPS_PROXY;unset ALL_PROXY;'

run_cmd() {
  export HTTP_PROXY=$PROXY_URL;
  export HTTPS_PROXY=$PROXY_URL;
	export ALL_PROXY=$PROXY_URL
	$*
	unsetproxy
}
alias px=run_cmd $*

# Mac proxy
alias macproxysetup='networksetup -setwebproxy Wi-Fi $P_ADDRESS $P_PORT && networksetup -setsecurewebproxy Wi-Fi $P_ADDRESS $P_PORT && networksetup -setsocksfirewallproxy Wi-Fi $P_ADDRESS $P_PORT'
alias macproxystart='networksetup -setwebproxystate Wi-Fi on && networksetup -setsecurewebproxystate Wi-Fi on && networksetup -setsocksfirewallproxystate Wi-Fi on'
alias macproxystop='networksetup -setwebproxystate Wi-Fi off && networksetup -setsecurewebproxystate Wi-Fi off && networksetup -setsocksfirewallproxystate Wi-Fi off'
