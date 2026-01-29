#!/bin/bash

#--------------------------------------------------------------------#
#                             Nix Config                             #
#--------------------------------------------------------------------#
configure_nix() {
  local nix_config_dir=$HOME/.config/nix
  local nix_config_file=$nix_config_dir/nix.conf

  if [[ -f "$nix_config_file" ]]; then
    echo "$nix_config_file already exists. Not editing."
  else
    echo "Creating $nix_config_file..."
    mkdir -p "$nix_config_dir"
    echo "extra-experimental-features = nix-command flakes" >> "$nix_config_file"
  fi
}

#--------------------------------------------------------------------#
#                       Nix Darwin Activation                        #
#--------------------------------------------------------------------#
activate_nix_darwin() {
  if [[ $OSTYPE == 'darwin'* ]]; then
    local nix_darwin_dir=/etc/nix-darwin

    if [[ -d "$nix_darwin_dir" ]]; then
      echo "$nix_darwin_dir already exists. Not creating symlink."
    else
      echo "Creating $nix_darwin_dir symlink..."
      sudo ln -s ~/dotfiles/nix /etc/nix-darwin
    fi

    echo "Activating nix-darwin..."
    sudo nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch || exit 1
  fi
}

#--------------------------------------------------------------------#
#                      Home Manager Activation                       #
#--------------------------------------------------------------------#
activate_home_manager() {
  local home_manager_dir=$HOME/.config/home-manager

  if [[ -d "$home_manager_dir" ]]; then
    echo "$home_manager_dir already exists. Not creating symlink."
  else
    echo "Creating $home_manager_dir symlink..."
    ln -s ~/dotfiles/nix "$home_manager_dir"
  fi

  echo "Activating home-manager..."
  nix run home-manager -- switch -b backup || exit 1
}

#--------------------------------------------------------------------#
#                               Script                               #
#--------------------------------------------------------------------#
configure_nix
activate_nix_darwin
activate_home_manager
