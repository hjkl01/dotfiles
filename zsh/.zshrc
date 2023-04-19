source ~/.dotfiles/.env

for file in ~/.dotfiles/zsh/*.sh; do
  if [ -d "$file" ]; then
    echo "$file is directory"
  elif [ -f "$file" ]; then
    # echo "$file is file"
    source $file
  fi
done

source ~/.dotfiles/zsh/zshrc
