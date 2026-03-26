# echo "🀄🀅 🀆 💻 😈 🤓   $HOST  "
# https://emojiterra.com/

# for i in {0..255}; do print -P "%F{$i}颜色 $i %f"; done
# for i in {0..16}; do print -P "%F{$i}颜色 $i %f"; done

function hostname() {
	if [[ $(uname) == 'Darwin' ]]; then
    echo "🍎 %K{blue}%F{black}$HOST%k%F{blue}"
	elif [[ $(uname) == 'Linux' ]]; then
    echo "🖥️ %K{blue}%F{black}$HOST%k%F{blue}"
	else
		echo "Nonsupport system"
	fi
}

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

function current_time {
  echo [ %F{cyan}%D{%Y-%m-%d %H:%M:%S}%f ]
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $
PROMPT="
%K{blue}%F{black}%n%k%F{blue} \
%{$fg[white]%}at \
%K{green}%F{black}$(box_name)%k%F{green} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(current_time) %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )
%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "

if [[ "$USER" == "root" ]]; then
PROMPT="
%K{red}%F{black}%n%k%F{red} \
%{$fg[white]%}at \
%K{red}%F{black}$(box_name)%k%F{red} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(current_time) %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) \
%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "
fi
