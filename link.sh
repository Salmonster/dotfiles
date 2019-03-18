#!/bin/bash

ln -siv $(pwd)/.vimrc ~/.vimrc
ln -siv $(pwd)/.zshrc ~/.zshrc
ln -siv $(pwd)/.bashrc ~/.bashrc
ln -siv $(pwd)/.ctags ~/.ctags
ln -siv $(pwd)/.ackrc ~/.ackrc
ln -siv $(pwd)/.gitconfig ~/.gitconfig
ln -siv $(pwd)/.ansible.cfg ~/.ansible.cfg
ln -siv $(pwd)/salman.zsh-theme $ZSH/themes/salman.zsh-theme
#
# The above commands will create $HOME level dotfiles as symlinks to files in this repo
# on whatever device this script is cloned and executed in.
# If those files already exist, you will be prompted to unlink those files so that the 
# new link can occur.
# You can later convert these symlinks to hardlinks to the same files, such as with:
# 	ln -f "$(readlink <symlink>)" <symlink>
