#!/bin/bash

sys=$(uname -s)

echo "Beginning installation"

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

  if [ ! $(cat /etc/shells | grep -w /usr/local/bin/zsh) ]; then
    sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
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
  (sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")
fi

echo ""

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

echo ""

echo "Backing up any existing dotfiles..."
[[ ! -f ~/.zshrc ]] || mv ~/.zshrc $backupdir/zshrc
[[ ! -f ~/.vimrc ]] || mv ~/.vimrc $backupdir/vimrc
[[ ! -d ~/.vim ]] || mv ~/.vim $backupdir/vim
echo "Done backing up files"

echo ""

echo "Symlinking dotfiles to $dir directory..."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/vimrc ~/.vimrc
ln -s $dir/vim ~/.vim
echo "Done symlinking files"

echo ""

echo "Configuring Vim plugins..."
if [[ -d ~/.vim/bundle/Vundle.vim ]]
then
  vim +PluginClean +PluginUpdate +qall
else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi
echo "Done configuring Vim plugins"

echo ""

echo "Done installing"
