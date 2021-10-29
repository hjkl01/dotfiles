judgeIfExists(){
    if [ -e $2 ]; then
        echo "$2 exists"
    	else
        ln -s $1 $2
    fi
    echo "$1 $2"
}


judgeIfExists ~/.dotfiles/config/pip.conf ~/.config/pip/pip.conf
judgeIfExists ~/.dotfiles/config/gitconfig ~/.gitconfig
judgeIfExists ~/.dotfiles/config/npmrc ~/.npmrc
judgeIfExists ~/.dotfiles/config/yarnrc ~/.yarnrc
