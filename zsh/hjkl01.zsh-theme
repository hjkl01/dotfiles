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

# Git info (inspired by robbyrussell theme)
function git_prompt_info() {
  # Check if we're in a git repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return
  fi
  
  # Get the current branch name
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  
  if [[ -n "$branch" ]]; then
    # Check git status for indicators (use git_status to avoid conflict with zsh built-in)
    local git_status=""
    
    # Check for staged changes
    if ! git diff --cached --quiet 2>/dev/null; then
      git_status+="+"
    fi
    
    # Check for unstaged changes
    if ! git diff --quiet 2>/dev/null; then
      git_status+="✎"
    fi
    
    # Check for untracked files
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      git_status+="?"
    fi
    
    # Check if ahead/behind remote
    local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
    
    if [[ "$ahead" -gt 0 ]]; then
      git_status+="↑${ahead}"
    fi
    if [[ "$behind" -gt 0 ]]; then
      git_status+="↓${behind}"
    fi
    
    # Format: on git:BRANCH [STATUS]
    local branch_info="%F{green}git:%F{white}${branch}"
    if [[ -n "$git_status" ]]; then
      branch_info+="%F{yellow} ${git_status}"
    fi
    
    echo "on ${branch_info}"
  fi
}

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $
PROMPT="
%K{blue}%F{black}%n%k%F{blue} \
%{$fg[white]%}at \
%K{green}%F{black}$(box_name)%k%F{green} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(git_prompt_info) $(current_time) %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )
%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "

if [[ "$USER" == "root" ]]; then
PROMPT="
%K{red}%F{black}%n%k%F{red} \
%{$fg[white]%}at \
%K{red}%F{black}$(box_name)%k%F{red} \
%{$fg[white]%}in \
%K{yellow}%F{black}[${current_dir}]%k%F{yellow} \
$(git_prompt_info) $(current_time) %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )
%{$terminfo[bold]$fg[white]%}› %{$reset_color%} "
fi
