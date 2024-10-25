{
  description = "jackie's nix configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
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
      user = builtins.getEnv "USER";
      home-dir = builtins.getEnv "HOME";
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      darwinConfigurations.personal = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              inherit user;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit home-dir;
          inherit inputs;
          inherit user;
        };
        modules = [ ./home.nix ];
      };
    };
}
