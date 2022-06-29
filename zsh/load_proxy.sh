# proxy config
export PROXY_URL="socks5://127.0.0.1:7890"
alias setproxy='export ALL_PROXY=$PROXY_URL'
alias unsetproxy='unset ALL_PROXY; unset http_proxy; unset https_proxy'

run_cmd(){
  export ALL_PROXY=$PROXY_URL
  $*
  unset ALL_PROXY; unset http_proxy; unset https_proxy
}
alias px=run_cmd $*
