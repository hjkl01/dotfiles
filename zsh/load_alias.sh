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
# alias_if_program_exists nvim vi

# brew install glib
alias rr="gio trash"
alias tt='TERM=screen-256color-bce tmux -f ~/.dotfiles/config/tmux.conf'
alias vi="nvim"
alias clean_nvim='rm -rf ~/.local/share/nvim/ ~/.cache/nvim ~/.dotfiles/nvim/plugin'
# curl cht.sh/rsync

# export EDITOR='nvim'

# alias
alias cc='cd ~/.dotfiles'
alias ii='vi $(fzf --height 40%)'

# find by name
# find . -name "*.log"
# grep "hello" example.txt
# grep -r "hello" my_directory
alias fd='find . -name '
alias pc='proxychains4'
alias scpr='rsync -zvauP --exclude="logs" --exclude="venv" --exclude="go" --exclude="node_modules" --rsh=ssh'
# alias getpass='openssl rand -base64 20'
alias getpass='openssl rand -hex 20'

# alias getip='curl ipinfo.io/ip'
# alias getip='curl -L tool.lu/ip'
# alias getip='curl http://api.ipify.org'
# alias gip='curl http://cip.cc'
alias gip='curl -s ipinfo.io'
alias gip6='curl -6 https://ifconfig.co/ip'
alias wt='curl wttr.in/nanjing'

# vultr
alias vc='vultr-cli'

www() {
	python -m http.server 80 -d "$1"
}
wqr() {
	python ~/.dotfiles/config/sharefile.py "$1"
}

cdd() {
	cd $1
	ls -G
}

fkill() {
	# pid=$(ps -ef | sed 1d | sk --regex -m -e -q "$1" | awk '{print $2}')
	pid=$(ps -ef | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo "$pid" | xargs kill -"${2:-9}"
	fi
}
