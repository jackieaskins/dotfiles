#!/bin/bash

sys=$(uname -s)

######################### Install Zsh, Oh My Zsh & Vim #########################

# Determine the system & install method
if [ $sys = "Darwin" ]
then
  # Install Xcode Command Line Tools if not already installed
  if [ ! $(xcode-select -p) ]; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
  fi

  # Install or update Homebrew
  if [ ! $(which brew) ]; then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "Updating Homebrew..."
    brew update
  fi

  # Install or upgrade Zsh via Homebrew
  if [ ! $(brew ls | grep -w zsh) ]; then
    echo "Installing Zsh via Homebrew..."
    brew install zsh
  else
    echo "Upgrading Zsh via Homebrew..."
    brew upgrade zsh
  fi

  # Install or upgrade Vim via Homebrew
  if [ ! $(brew ls | grep -w vim) ]; then
    echo "Installing Vim via Homebrew..."
    brew install vim
  else
    echo "Upgrading Vim via Homebrew..."
    brew upgrade vim
  fi
elif [ $(which apt-get) ]
then
  echo "Installing/updating Vim & Zsh..."
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install zsh
  sudo apt-get install vim
  echo "Done installing/updating Vim & Zsh"
elif [ $(which yum) ]
then
  echo "Installing/updating Vim & Zsh..."
  sudo yum upgrade
  sudo yum install zsh
  sudo yum install vim
  echo "Done installing/updating Vim & Zsh"
elif [ ! $(which zsh) ] && [ ! $(which vim) ]
then
  echo "Vim & Zsh are not installed, please install them and re-run the script"
  exit 1
elif [ ! $(which zsh) ]
then
  echo "Zsh is not installed, please install it and re-run the script"
  exit 1
elif [ ! $(which vim) ]
then
  echo "Vim is not installed, please install it and re-run the script"
  exit 1
fi

if [ ! -d ~/.oh-my-zsh ]
then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

################################  Set up iTerm ################################
# TODO: Set up iTerm
# Specify the preferences directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

############################### Set up dotfiles ###############################

timestamp=$(date +%Y%m%d%H%M%S) # timestamp for backup
dir=~/dotfiles # dotfiles directory
backupdir=~/dotfiles_backups/$timestamp # backup directory for old dotfiles

echo "Creating dotfiles backup directory..."
mkdir -p $backupdir
echo "Backup directory created at $backupdir"

[[ -d ~/.vim ]] || mkdir -p ~/.vim
mkdir -p $backupdir/vim
mkdir -p $backupdir/zsh

echo "Backing up any existing dotfiles..."
mv ~/.zshrc $backupdir/zshrc
mv ~/.oh-my-zsh/custom/aliases.zsh $backupdir/zsh/aliases.zsh
mv ~/.oh-my-zsh/custom/functions.zsh $backupdir/zsh/functions.zsh
mv ~/.vimrc $backupdir/vimrc
mv ~/.vim/plugins.vim $backupdir/vim/plugins.vim
mv ~/.vim/tabline.vim $backupdir/vim/tabline.vim
echo "Done backing up files"

echo ""

echo "Symlinking dotfiles to $dir directory..."
ln $dir/zshrc ~/.zshrc
ln $dir/zsh/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
ln $dir/zsh/functions.zsh ~/.oh-my-zsh/custom/functions.zsh
ln $dir/vimrc ~/.vimrc
ln $dir/vim/plugins.vim ~/.vim/plugins.vim
ln $dir/vim/tabline.vim ~/.vim/tabline.vim
echo "Done symlinking files"

echo "Configuring Vim plugins"
[[ -d ~/.vim/bundle ]] || mkdir -p ~/.vim/bundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginClean +qall
vim +PluginInstall +qall
vim +PluginUpdate +qall
echo "Done configuring Vim plugins"
