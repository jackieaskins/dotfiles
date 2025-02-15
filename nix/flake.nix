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

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{
      catppuccin,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      ...
    }:
    let
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";

      config = import "${homeDirectory}/dotfiles_custom/nix-custom.nix";
      fullName = config.fullName;
      email = config.email;
      hostname = config.hostname;
      system = config.system;

      homeManagerArgs = {
        inherit email;
        inherit fullName;
        inherit inputs;
        inherit username;
        inherit homeDirectory;
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit pkgs;
        inherit system;
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = username;
            };
          }

          home-manager.darwinModules.home-manager
          {
            users.users.${username}.home = homeDirectory;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = homeManagerArgs;
              users.${username} = {
                imports = [
                  ./home.nix
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = homeManagerArgs;
        modules = [
          ./home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
}
