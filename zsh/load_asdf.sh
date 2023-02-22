#! /bin/sh

# asdf
# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
# asdf list all nodejs

# mac
# . /usr/local/opt/asdf/libexec/asdf.sh

# linux
ASDFSH=$HOME/.asdf/asdf.sh
if [ -f $ASDFSH ]; then
  . $ASDFSH
fi
