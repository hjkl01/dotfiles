if [[ -n "$ZELLIJ" ]]; then
  _zellij_tab_title() {
    local dir="${PWD/#$HOME/~}"
    local short_dir
    short_dir=$(echo "$dir" | awk -F'/' '{if(NF<=2) print $0; else print $(NF-1)"/"$NF}')
    zellij action rename-tab "$short_dir" >/dev/null 2>&1 &!
  }

  precmd_functions+=(_zellij_tab_title)
fi
