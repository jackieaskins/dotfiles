# My Dotfiles

My dotfiles for Hammerspoon, Karabiner, Neovim, Nix, Vim, QMK, Tmux, WezTerm, and Zsh.

![Image showcasing current setup](https://github.com/jackieaskins/dotfiles/blob/media/setup.png?raw=true)

## Installation

1. On MacOS, install XCode developer tools:
   ```bash
   xcode-select --install 2> /dev/null
   ```

1. Install [Nix](https://nixos.org/download):
   ```bash
   # On Linux:
   sh <(curl -L https://nixos.org/nix/install) --daemon
   # On MacOS:
   sh <(curl -L https://nixos.org/nix/install)
   ```

1. Close the shell and open a new one.

1. Add custom configuration files to `~/dotfiles_custom`:
    * `nvim-custom.lua`
    * `hammerspoon-custom.lua`
    * `nix-custom.nix`

1. Clone this repo:
    ```bash
    git clone -b nix https://github.com/jackieaskins/dotfiles.git ~/dotfiles
    ```

1. Enable "experimental" flake support:
   ```bash
   mkdir -p ~/.config/nix/
   echo "extra-experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

1. On MacOS only, apply the nix-darwin config:
    ```bash
    nix run nix-darwin -- switch --flake ~/dotfiles/nix#personal --impure
    ```

1. Apply the home-manager config:
    ```bash
    nix run home-manager -- switch --flake ~/dotfiles/nix --impure
    ```

1. Restart your device or log out and back in to ensure all settings are applied.
