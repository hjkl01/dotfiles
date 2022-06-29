ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[red]%}➦"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

function hostname {
	echo "🀄   $HOST  "
}
# echo "🀄 💻 😈 🤓   $HOST  "

# show git info
# %{$reset_color%}$(git_prompt_info)%{$reset_color%}$(git_prompt_ahead)

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%})
%{$fg[green]%} $(hostname) %{$fg[yellow]%}[%~]  %{$reset_color%}$(git_prompt_info) %{$fg[green]%}[%D %*]%{$reset_color%}
%_ $(prompt_char) '
