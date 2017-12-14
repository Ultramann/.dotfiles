#!/usr/env bash

dotfiledir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

link() {
  # os dependent
  if [ `uname` == 'Darwin' ]; then
    # install
    brew install vim
    brew install tmux

    # designate tmux os
    tmuxdir=osx
  elif [ `uname` == 'Linux' ]; then
    # install
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install vim

    # designate tmux os
    tmuxdir=linux
  else
    echo Unknown operating system.
  fi

  # git
  ln -s $dotfiledir/gitconfig ~/.gitconfig

  # vim
  ln -s $dotfiledir/vimrc ~/.vimrc
  ln -s $dotfiledir/vim/ ~/.vim
  git submodule init && git submodule update

  # ipython
  ln -s $dotfiledir/ipython/ ~/.ipython

  # tmux
  ln -s $dotfiledir/tmux/$tmuxdir/tmux.conf ~/.tmux.conf
}

unlink() {
  links=".gitconfig .vimrc .vim .ipython .tmux.conf"
  for link in $links; do
    rm ~/$link
  done
}

if [ "$1" = "link" ]; then
  link
elif [ "$1" = "unlink" ]; then
  unlink 
elif [ "$1" = "reload" ]; then
  unlink
  link
else
  echo "Unknown option. Choose from {link|unlink|reload}."
fi
