#!/bin/zsh
ln -siv $(pwd)/.vimrc ~/.vimrc
ln -siv $(pwd)/.zshrc ~/.zshrc
# ln -siv $(pwd)/.tmux.conf ~/.tmux.conf
# ln -siv $(pwd)/.gitconfig ~/.gitconfig
#
# The above commands will create $HOME level dotfiles as symlinks to files in this repo
# on whatever device this script is cloned and executed in.
# You can later convert those symlinks to hardlinks to the same files, such as with:
# 	ln -f "$(readlink <symlink>)" <symlink>
