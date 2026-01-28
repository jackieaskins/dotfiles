#!/bin/bash

if [[ -f $HOME/.config/nix/nix.conf ]]; then
  echo "$HOME/.config/nix/nix.conf already exists. Not editing."
else
  echo "Creating $HOME/.config/nix/nix.conf."
  mkdir -p $HOME/.config/nix
  echo "extra-experimental-features = nix-command flakes" >> $HOME/.config/nix/nix.conf
fi

if [[ -d $HOME/.config/home-manager ]]; then
  echo "$HOME/.config/home-manager already exists. Not creating symlink."
else
  echo "Creating $HOME/.config/home-manager symlink."
  ln -s ~/dotfiles/nix $HOME/.config/home-manager
fi

echo "Activating home-manager..."
echo ""
nix run home-manager -- switch -b backup

if [[ $OSTYPE == 'darwin'* ]]; then
  if [[ -d /etc/nix-darwin ]]; then
    echo "/etc/nix-darwin already exists. Not creating symlink."
  else
    echo "Creating /etc/nix-darwin symlink."
    sudo ln -s ~/dotfiles/nix /etc/nix-darwin
  fi

  echo "Activating nix-darwin..."
  echo ""
  sudo nix run nix-darwin -- switch
fi
