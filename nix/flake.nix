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
      homeManagerArgs = { inherit inputs; };
    in
    {
      # sudo darwin-rebuild switch --flake .#darwin --impure
      darwinConfigurations.darwin = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
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

          home-manager.darwinModules.home-manager
          (
            { config, ... }:
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = homeManagerArgs;
                users.${config.system.primaryUser} = ./home;
              };
            }
          )
        ];
      };

      homeConfigurations.linux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = homeManagerArgs;
        modules = [ ./home ];
      };
    };
}
