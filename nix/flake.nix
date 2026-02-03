{
  description = "jackie's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    wezterm-nightly-overlay = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      ...
    }:
    let
      args = {
        inherit inputs;
        username = "jackie";
        homeDirectory = "/Users/jackie";
      };
    in
    {
      darwinConfigurations."Jackies-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs = args;
        modules = [
          ./configuration

          nix-homebrew.darwinModules.nix-homebrew
          (
            { config, ... }:
            {
              nix-homebrew = {
                enable = true;
                user = config.system.primaryUser;
                autoMigrate = true;
              };
            }
          )
        ];
      };

      homeConfigurations.jackie = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = args;
        modules = [ ./home ];
      };
    };
}
