#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "Checking for Requirements..."
read -p "Have you completed all of the prerequisites outlined in the README? (Y/N) " ready
if [ $ready != "Y" ] && [ $ready != "y" ]
then
  echo -e "${RED}Please complete the prequisites before beginning installation and Oh-My-Zsh before beginning installation"
  exit 1
fi

echo -e "Beginning installation\n"

timestamp=$(date +%Y%m%d%H%M%S) # timestamp for backup
dir=~/dotfiles # dotfiles directory
backupdir=~/dotfiles_backups/$timestamp # backup directory for old dotfiles

[ -d ~/.zfunctions ] || mkdir ~/.zfunctions
mkdir $backupdir/zfunctions

echo -e "Creating dotfiles backup directory..."
mkdir -p $backupdir
echo -e "Backup directory created at $backupdir\n"

echo -e "Backing up any existing dotfiles..."
[ ! -f ~/.zshrc ] || mv ~/.zshrc $backupdir/zshrc
[ ! -f ~/.vimrc ] || mv ~/.vimrc $backupdir/vimrc
[ ! -d ~/.vim ] || mv ~/.vim $backupdir/vim
[ ! -f ~/.zfunctions/prompt_pure_setup ] || mv ~/.zfunctions/prompt_pure_setup $backupdir/zfunctions/prompt_pure_setup
[ ! -f ~/.zfunctions/async ] || mv ~/.zfunctions/async $backupdir/zfunctions/async
echo -e "Done backing up files\n"

echo -e "Symlinking dotfiles to $dir directory..."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/vim ~/.vim
ln -s $dir/vimtemp ~/.vimrc
ln -s $dir/pure/pure.zsh ~/.zfunctions/prompt_pure_setup
ln -s $dir/pure/async.zsh ~/.zfunctions/async
echo -e "Done symlinking files\n"

echo -e "Configuring Vim plugins..."
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +PluginClean +PluginUpdate +qall
rm ~/.vimrc
ln -s $dir/vimrc ~/.vimrc
echo -e "Done configuring Vim plugins\n"

echo -e "${GREEN}Done installing\n${NC}"

echo -e "If using iTerm, configure it to load preferences from ~/dotfiles/iterm (refer to the README)"
