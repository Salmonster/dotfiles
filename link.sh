#!/bin/zsh
ln -siv $(pwd)/.vimrc ~/.vimrc
ln -siv $(pwd)/.zshrc ~/.zshrc
ln -siv $(pwd)/.ctags ~/.ctags
# ln -siv $(pwd)/.tmux.conf ~/.tmux.conf
# ln -siv $(pwd)/.gitconfig ~/.gitconfig
#
# The above commands will create $HOME level dotfiles as symlinks to files in this repo
# on whatever device this script is cloned and executed in.
# If those files already exist, you will be prompted to unlink those files so that the 
# new link can occur.
# You can later convert these symlinks to hardlinks to the same files, such as with:
# 	ln -f "$(readlink <symlink>)" <symlink>
