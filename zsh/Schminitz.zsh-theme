ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[red]%}➦"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

function hostname {
	if [[ $(uname) == 'Darwin' ]]; then
    echo "🍎 "
	elif [[ $(uname) == 'Linux' ]]; then
    echo "🖥️ $HOST "
	else
		echo "Nonsupport system"
	fi
}

# echo "🀄🀅 🀆 💻 😈 🤓   $HOST  "
# https://emojiterra.com/

# show git info
# %{$reset_color%}$(git_prompt_info)%{$reset_color%}$(git_prompt_ahead)

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%})
$ZSH_ENV %{$fg[green]%} $(hostname) %{$fg[yellow]%}[%~]  %{$reset_color%}$(git_prompt_info) %{$fg[green]%}[%D %*]%{$reset_color%}
%_ $(prompt_char) '
