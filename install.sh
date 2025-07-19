#!/bin/bash

if [[ -d /etc/nix-custom ]]; then
  echo "/etc/nix-custom already exists. Not creating symlink."
else
  echo "Creating /etc/nix-custom symlink."
  sudo ln -s ~/dotfiles_custom/nix /etc/nix-custom
fi

if [[ -f $HOME/.config/nix/nix.conf ]]; then
  echo "$HOME/.config/nix/nix.conf already exists. Not editing."
else
  echo "Creating $HOME/.config/nix/nix.conf."
  mkdir -p $HOME/.config/nix
  echo "extra-experimental-features = nix-command flakes" >> $HOME/.config/nix/nix.conf
fi

if [[ $OSTYPE == 'darwin'* ]]; then
  if [[ -d /etc/nix-darwin ]]; then
    echo "/etc/nix-darwin already exists. Not creating symlink."
  else
    echo "Creating /etc/nix-darwin symlink."
    sudo ln -s ~/dotfiles/nix /etc/nix-darwin
  fi

  echo "Activating with nix-darwin..."
  echo ""
  sudo nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake /etc/nix-darwin#darwin --impure
else
  echo "Activating with home-manager..."
  echo ""
  nix run home-manager -- switch -b backup --flake ~/dotfiles/nix#linux --impure
fi
