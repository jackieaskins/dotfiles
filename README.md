# My Dotfiles

My dotfiles for Hammerspoon, Karabiner, Neovim, Nix, QMK, Tmux, WezTerm, and Zsh.

## Installation

1. On MacOS, install XCode developer tools:

   ```bash
   xcode-select --install 2> /dev/null
   ```

1. Install [Nix](https://nixos.org/download)

1. Close the shell and open a new one.

1. Add custom configuration files to `~/dotfiles_custom` and add to git:

   - `nvim-custom.lua`
   - `hammerspoon-custom.lua`
   - `nix/configuration.nix`
      - At a minimum: `system.primaryUser` & `users.user.${primaryUser}.home`
   - `nix/home.nix`
      - At a minimum: `programs.git.userEmail` & `programs.git.userName`

1. Clone this repo:

   ```bash
   git clone -b nix https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

1. Run install script:

   ```bash
   ~/dotfiles/install.sh
   ```

1. Restart your device or log out and back in to ensure all settings are applied.
