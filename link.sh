#!/bin/bash

dotfiles=("zshrc" "vimrc" "tmux.conf" "gitconfig" "gitignore")

for file in ${dotfiles[@]}
do
  dotfile=~/.${file}
  if [ -e ${dotfile} ]; then
    echo ${dotfile} already exists.
  else
    echo create ${dotfile}.
    ln -s $(pwd)/${file} ${dotfile}
  fi
done

confdirs=("iterm")

for dir in  ${confdirs[@]}
do
  dirpath=~/${dir}
  if [ -d ${dirpath} ]; then
    echo ${dirpth} already exists.
  else
    echo create ${dirpath}.
    ln -s $(pwd)/${dir} ${dirpath}
  fi
done
