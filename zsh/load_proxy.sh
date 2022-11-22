#! /bin/sh

# proxy config

# if want auto switch, use clash port 7890 
# or use proxychains

export PROXY_URL="http://127.0.0.1:7890"
alias setproxy='export ALL_PROXY=$PROXY_URL'
alias unsetproxy='unset ALL_PROXY; unset http_proxy; unset https_proxy'

run_cmd(){
  export ALL_PROXY=$PROXY_URL
  $*
  unset ALL_PROXY; unset http_proxy; unset https_proxy
}
alias px=run_cmd $*
