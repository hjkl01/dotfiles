#! /bin/sh

# git config
alias gc='git clone'
alias gcd='git clone --depth=1'
alias gs='git status'
alias ggp='git log --stat -p'
alias ga='git add'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'

gitpush() {
	git commit -m $1
	git push
}

# fshow - git commit browser
gitcb() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
			--bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
