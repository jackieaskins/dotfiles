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
      mkDarwinConfig =
        {
          username,
          homeDirectory,
          modules,
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration
            (
              { ... }:
              {
                system.primaryUser = username;
                users.users.${username}.home = homeDirectory;
              }
            )

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
          ]
          ++ modules;
        };

      mkHomeConfig =
        {
          username,
          homeDirectory,
          email,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
            inherit email;
          };
          modules = [
            ./home

            (
              { ... }:
              {
                home = {
                  username = username;
                  homeDirectory = homeDirectory;
                };
              }
            )
          ]
          ++ modules;
        };

      emailBase = "askinsjacqueline";
      personalUsername = "jackie";
      personalHomeDirectory = "/Users/jackie";
      personalEmail = "${emailBase}@gmail.com";
    in
    {
      mkDarwinConfig = mkDarwinConfig;
      mkHomeConfig = mkHomeConfig;

      darwinConfigurations."Jackies-MacBook-Pro" = mkDarwinConfig {
        username = personalUsername;
        homeDirectory = personalHomeDirectory;
        modules = [ ./personal/configuration.nix ];
      };

      homeConfigurations.jackie = mkHomeConfig {
        username = personalUsername;
        homeDirectory = personalHomeDirectory;
        email = personalEmail;
        modules = [ ./personal/home.nix ];
      };
    };
}
