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
alias fd='find . -name '
alias pc='proxychains4'
alias scpr='rsync -Pzv --exclude "logs" --rsh=ssh'
# alias getpass='openssl rand -base64 20'
alias getpass='openssl rand -hex 20'
alias www='ifconfig en0 && python -m http.server 80 -d $1 '
# alias getip='curl ipinfo.io/ip'
# alias getip='curl -L tool.lu/ip'
# alias getip='curl http://api.ipify.org'
alias gip='curl http://cip.cc'
alias wt='curl wttr.in/nanjing'

