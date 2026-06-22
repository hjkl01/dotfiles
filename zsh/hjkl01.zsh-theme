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

# Pre-calculate machine name to prevent fork in PROMPT
local my_box_name
if [[ -f ~/.box-name ]]; then
  my_box_name=$(<~/.box-name)
else
  my_box_name=$HOST
fi

# Directory info.
local current_dir='%~'

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
    if ! git --no-optional-locks diff --cached --quiet 2>/dev/null; then
      git_status+="+"
    fi

    # Check for unstaged changes
    if ! git --no-optional-locks diff --quiet 2>/dev/null; then
      git_status+="✎"
    fi

    # Check for untracked files
    local untracked
    untracked=$(git --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)
    if [[ -n "$untracked" ]]; then
      git_status+="?"
    fi

    # Check if ahead/behind remote
    local counts
    # Output format: <ahead> \t <behind>
    counts=($(git --no-optional-locks rev-list --left-right --count HEAD...@{u} 2>/dev/null))
    if [[ ${#counts[@]} -eq 2 ]]; then
      local ahead=${counts[1]}
      local behind=${counts[2]}

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
setopt PROMPT_SUBST

PROMPT='
%K{blue}%F{black}%n%k%f %F{white}at %K{green}%F{black}${my_box_name}%k%f %F{white}in %K{yellow}%F{black}[${current_dir}]%k%f $(git_prompt_info) [ %F{cyan}%D{%Y-%m-%d %H:%M:%S}%f ] %(?:%B%F{green}%1{➜%} :%B%F{red}%1{➜%} )
%B%F{white}› %f%b '

if [[ "$USER" == "root" ]]; then
PROMPT='
%K{red}%F{black}%n%k%f %F{white}at %K{red}%F{black}${my_box_name}%k%f %F{white}in %K{yellow}%F{black}[${current_dir}]%k%f $(git_prompt_info) [ %F{cyan}%D{%Y-%m-%d %H:%M:%S}%f ] %(?:%B%F{green}%1{➜%} :%B%F{red}%1{➜%} )
%B%F{white}› %f%b '
fi