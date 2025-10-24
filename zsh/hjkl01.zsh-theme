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

# VCS
YS_VCS_PROMPT_PREFIX1="%{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%} "
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}✔︎"

# Git info.
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"


# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $
PROMPT="
%K{blue}%F{black}%n%k%F{blue} \
%{$fg[white]%}at \
%K{green}%F{black}$(box_name)%k%F{green} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(current_time) \

%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "

if [[ "$USER" == "root" ]]; then
PROMPT="
%K{red}%F{black}%n%k%F{red} \
%{$fg[white]%}at \
%K{red}%F{black}$(box_name)%k%F{red} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(current_time) \

%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "
fi
