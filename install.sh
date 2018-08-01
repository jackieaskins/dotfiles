#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "Checking for Requirements..."
read -p "Have you completed all of the prerequisites outlined in the README? (Y/N) " ready
if [ $ready != "Y" ] && [ $ready != "y" ]
then
  echo "${RED}Please complete the prequisites before beginning installation and Oh-My-Zsh before beginning installation\n"
  exit 1
fi

echo "Beginning installation\n"

timestamp=$(date +%Y%m%d%H%M%S) # timestamp for backup
dir=~/dotfiles # dotfiles directory
backupdir=~/dotfiles_backups/$timestamp # backup directory for old dotfiles

echo "Creating dotfiles backup directory..."
mkdir -p $backupdir
echo "Backup directory created at $backupdir\n"

echo "Backing up any existing dotfiles..."
[ ! -f ~/.zshrc ] || mv ~/.zshrc $backupdir/zshrc
[ ! -f ~/.vimrc ] || mv ~/.vimrc $backupdir/vimrc
[ ! -d ~/.vim ] || mv ~/.vim $backupdir/vim
echo "Done backing up files\n"

echo "Symlinking dotfiles to $dir directory..."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/vim ~/.vim
ln -s $dir/vimtemp ~/.vimrc
echo "Done symlinking files\n"

echo "Configuring Vim plugins..."
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +PluginClean +PluginUpdate +qall
rm ~/.vimrc
ln -s $dir/vimrc ~/.vimrc
echo "Done configuring Vim plugins\n"

echo "${GREEN}Done installing\n${NC}"

echo "If using iTerm:"
echo "Configure iTerm to load preferences from ~/dotfiles/iTerm (refer to the README)"
