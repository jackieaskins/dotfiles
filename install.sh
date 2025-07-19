#!/bin/bash

sudo ln -s ~/dotfiles_custom/nix /etc/nix-custom

if [[ $OSTYPE == 'darwin'* ]]; then
  sudo ln -s ~/dotfiles/nix /etc/nix-darwin

  sudo nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake /etc/nix-darwin#darwin --impure
else
  nix run home-manager -- switch --flake ~/dotfiles/nix#linux --impure
fi
