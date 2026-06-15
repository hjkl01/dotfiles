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
  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null) || return

  # Get the current branch name
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || \
  branch=$(git describe --tags --exact-match 2>/dev/null) || \
  branch=$(git rev-parse --short HEAD 2>/dev/null)

  if [[ -n "$branch" ]]; then
    # Check git status for indicators
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
    local untracked
    untracked=$(git ls-files --others --exclude-standard 2>/dev/null)
    if [[ -n "$untracked" ]]; then
      git_status+="?"
    fi

    # Check if ahead/behind remote
    local upstream
    upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
    if [[ -n "$upstream" ]]; then
      local ahead behind
      ahead=$(git rev-list --count "${upstream}..HEAD" 2>/dev/null)
      behind=$(git rev-list --count "HEAD..${upstream}" 2>/dev/null)

      if [[ "$ahead" -gt 0 ]]; then
        git_status+="↑${ahead}"
      fi
      if [[ "$behind" -gt 0 ]]; then
        git_status+="↓${behind}"
      fi
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
