#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "Checking for Requirements..."
read -p "Have you completed all of the prerequisites outlined in the README? (Y/N) " ready
if [ $ready != "Y" ] && [ $ready != "y" ]
then
  echo -e "${RED}Please complete the prerequisites before beginning installation"
  exit 1
fi

echo -e "Beginning installation\n"

echo -e "Updating submodules..."
git submodule update
echo -e "Submodules updated\n"

timestamp=$(date +%Y%m%d%H%M%S) # timestamp for backup
dir=~/dotfiles # dotfiles directory
backupdir=~/dotfiles_backups/$timestamp # backup directory for old dotfiles

[ -d ~/.zfunctions ] || mkdir ~/.zfunctions
[ -d ~/.config ] || mkdir ~/.config
mkdir $backupdir/zfunctions
mkdir $backupdir/nvim

echo -e "Creating dotfiles backup directory..."
mkdir -p $backupdir
echo -e "Backup directory created at $backupdir\n"

echo -e "Backing up any existing dotfiles..."
[ ! -f ~/.zshrc ] || mv ~/.zshrc $backupdir/zshrc
[ ! -f ~/.vimrc ] || mv ~/.vimrc $backupdir/vimrc
[ ! -d ~/.ctags.d ] || mv ~/.ctags.d $backupdir/ctags.d
[ ! -f ~/.tern-config ] || mv ~/.tern-config $backupdir/tern-config
[ ! -f ~/.gitignore_global ] || mv ~/.gitignore_global $backupdir/gitignore_global
[ ! -d ~/.vim ] || mv ~/.vim $backupdir/vim
[ ! -d ~/.config/nvim ] || mv ~/.config/nvim $backupdir/nvim
[ ! -f ~/.zfunctions/prompt_pure_setup ] || mv ~/.zfunctions/prompt_pure_setup $backupdir/zfunctions/prompt_pure_setup
[ ! -f ~/.zfunctions/async ] || mv ~/.zfunctions/async $backupdir/zfunctions/async
[ ! -d ~/.iterm2_shell_integration.zsh ] || mv ~/.iterm2_shell_integration.zsh $backupdir/iterm2_shell_integration.zsh
[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf $backupdir/tmux.conf
echo -e "Done backing up files\n"

echo -e "Symlinking dotfiles to $dir directory..."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/vim ~/.vim
ln -s $dir/vim-common/plugin ~/.vim/plugin
ln -s $dir/nvim ~/.config/nvim
ln -s $dir/vim-common/plugin ~/.config/nvim/plugin
ln -s $dir/ctags.d ~/.ctags.d
ln -s $dir/tern-config ~/.tern-config
ln -s $dir/gitignore_global ~/.gitignore_global
ln -s $dir/vimrc ~/.vimrc
ln -s $dir/pure/pure.zsh ~/.zfunctions/prompt_pure_setup
ln -s $dir/pure/async.zsh ~/.zfunctions/async
ln -s $dir/iterm2_shell_integration.zsh ~/.iterm2_shell_integration.zsh
ln -s $dir/tmux.conf ~/.tmux.conf
echo -e "Done symlinking files\n"

echo -e "Configuring Global Gitignore..."
git config --global core.excludesfile ~/.gitignore_global
echo -e "Configured Global Gitignore\n"

echo -e "${GREEN}Done installing\n${NC}"

echo -e "If using iTerm, configure it to load preferences from ~/dotfiles/iterm (refer to the README)"
