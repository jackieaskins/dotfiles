#!/bin/bash

sudo ln -s ~/dotfiles/nix /etc/nix-darwin
sudo ln -s ~/dotfiles_custom/nix /etc/nix-custom

sudo nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake /etc/nix-darwin#darwin --impure
