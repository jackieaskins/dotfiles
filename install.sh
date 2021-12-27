#!/bin/bash

function success_echo() {
  local green='\033[0;32m'
  local nc='\033[0m'
  echo -e "$green$1\n$nc"
}

#--------------------------------------------------------------------#
#                            MacOS Check                             #
#--------------------------------------------------------------------#
is_mac=false
if [[ $OSTYPE == 'darwin'* ]]; then is_mac=true; fi

#--------------------------------------------------------------------#
#                       Personal Machine Check                       #
#--------------------------------------------------------------------#
echo -e "Are you installing on a personal machine?"
select yn in "Yes" "No"; do
  case $yn in
    Yes)
      is_personal_machine=true
      echo -e "Got it, this IS a personal machine."
      break
      ;;
    No)
      is_personal_machine=false
      echo -e "Got it, this IS NOT a personal machine."
      break
      ;;
  esac
done

echo -e "Beginning installation!\n"

#--------------------------------------------------------------------#
#                   Xcode Command Line Tools Check                   #
#--------------------------------------------------------------------#
if [ $is_mac = true ]; then
  echo -e "Making sure Xcode command line tools are installed..."
  xcode-select --install 2>/dev/null
  success_echo "Xcode command line tools installed."
else
  echo -e "Not on MacOS, not checking for Xcode Command Line Tools.\n"
fi

# TODO: Configure MacOS System Preferences

#--------------------------------------------------------------------#
#                   Homebrew Installation & Bundle                   #
#--------------------------------------------------------------------#
echo -e "Checking if Homebrew is installed..."
if [ -x "$(command -v brew)" ]; then
  echo -e "Homebrew is installed! We'll update it and upgrade your packages..."
  brew update
  brew upgrade
else
  echo -e "Homebrew is not installed, let's change that..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi
echo -e "Bundling Homebrew packages..."
brew bundle --file ./Brewfile

if [ $is_personal_machine = true ]; then
  echo -e "Bundling personal machine Homebrew packages..."
  brew bundle --file ./Brewfile_personal
else
  echo -e "Not on personal machine, not installing personal machine Homebrew packages."
fi
echo -e ""

#--------------------------------------------------------------------#
#                         Global Git Config                          #
#--------------------------------------------------------------------#
echo -e "Configuring Global Gitignore..."
git config --global core.excludesfile ~/.gitignore_global
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global rebase.autoStash true
success_echo "Configured Global Gitignore."

#--------------------------------------------------------------------#
#                    Dotfiles Backup & Symlinking                    #
#--------------------------------------------------------------------#
timestamp=$(date +%Y%m%d%H%M%S) # timestamp for backup
dotfiles_dir=~/dotfiles
backup_dir=~/dotfiles_backups/$timestamp

echo -e "Creating dotfiles backup directory..."
mkdir -p "$backup_dir"
mkdir "$backup_dir/nvim"
success_echo "Backup directory created at $backup_dir."

[ -d ~/.config ] || mkdir ~/.config

function backup_and_symlink() {
  local dotfile_path="$HOME/$1"
  local backup_path="$backup_dir/$2"
  local sym_path="$dotfiles_dir/$3"

  # Check if file or directory exists at $dotfile_path
  if [ -f "$dotfile_path" ] || [ -d "$dotfile_path" ]; then
    local sym
    sym=$(ls -l "$dotfile_path" | awk '{print $NF}') # Follow symlink of $dotfile_path

    # Check if $dotfile_path is already symlinked to $sym_path
    if [ ! "$sym" == "$sym_path" ]; then
      echo -e "$dotfile_path exists but is not symlinked to $sym_path, backing up and symlinking..."
      mv "$dotfile_path" "$backup_path"
      ln -s "$sym_path" "$dotfile_path"
    else
      echo -e "$dotfile_path is symlinked to $sym_path, no action required."
    fi
  else
    echo -e "$dotfile_path does not exist, symlinking..."
    ln -s "$sym_path" "$dotfile_path"
  fi
}

echo -e "Backing up and symlinking dotfiles..."
#                  dotfile           backup           sym
backup_and_symlink .zshrc            zshrc            zshrc
backup_and_symlink .vimrc            vimrc            vimrc
backup_and_symlink .vim              vim              vim
backup_and_symlink .config/nvim      nvim             nvim
backup_and_symlink .config/kitty     kitty            kitty
backup_and_symlink .tmux.conf        tmux.conf        tmux.conf
backup_and_symlink .gitignore_global gitignore_global gitignore_global
#                  dotfile           backup           sym
success_echo "Dotfiles backed up and symlinked."

#--------------------------------------------------------------------#
#                           Neovim Config                            #
#--------------------------------------------------------------------#
echo -e "Configuring Neovim..."
std_data_path=${XDG_CONFIG_HOME:-"$HOME/.local/share/nvim"}
install_path="$std_data_path/site/pack/packer/opt/packer.nvim"
if [ ! -d "$install_path" ]; then
  echo -e "Installing Packer.nvim..."
  git clone "https://github.com/wbthomason/packer.nvim" "$install_path"
else
  echo -e "Packer.nvim already exists."
fi
rm ./nvim/plugin/packer_compiled.*

echo -e "Running PackerSync, this may take a while..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
echo -e ""
success_echo "Done configuring Neovim."

success_echo "Congratulations, everything is done installing!"
exec /bin/zsh
