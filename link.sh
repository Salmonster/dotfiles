#!/bin/bash

ln -siv $(pwd)/.ackrc ~/.ackrc
ln -siv $(pwd)/.zshrc ~/.zshrc
ln -siv $(pwd)/.bashrc ~/.bashrc
ln -siv $(pwd)/.gitconfig ~/.gitconfig
ln -siv $(pwd)/.ansible.cfg ~/.ansible.cfg
# ln -siv $(pwd)/init.vim ~/.config/nvim/init.vim
ln -siv $(pwd)/config.lua ~/.config/nvim/lua/cosmic/config/config.lua
ln -siv $(pwd)/editor.lua ~/.config/nvim/lua/cosmic/config/editor.lua
mkdir -p ~/.config/ghostty && ln -siv $(pwd)/cmux/config ~/.config/ghostty/config
ln -siv $(pwd)/salman.zsh-theme $ZSH/themes/salman.zsh-theme

# The above commands will create $HOME level dotfiles as symlinks to files in this repo
# on whatever device this script is cloned and executed in.
# If those files already exist, you will be prompted to unlink those files so that the
# new link can occur.
# You can later convert these symlinks to hard links to the same inodes, such as with:
# 	ln -f "$(readlink <symlink>)" <symlink>

# CoC vim plugin config (for use with legacy neovim setup):
# Normally the first word suggested is selected by default.
# We disable that with the setting `"suggest.noselect": true`.
# Settings are saved in ~/.config/nvim/coc-settings.json
# which can be opened with command :CocConfig from a TS/X file.
# If it gets to be long then version-control it in dotfiles
# repo to symlink it as above. Otherwise set it like so:
# echo '{\n  "suggest.noselect": true\n}' > ~/.config/nvim/coc-settings.json
