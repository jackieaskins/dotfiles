#!/bin/bash

ln -s ~/dotfiles/nix /etc/nix-darwin
ln -s ~/dotfiles_custom/nix /etc/nix-custom

nix run nix-darwin -- switch --flake /etc/nix-darwin --impure
