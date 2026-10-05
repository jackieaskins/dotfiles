{
  description = "jackie's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    catppuccin.url = "github:catppuccin/nix";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  };

  outputs =
    inputs@{
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      self,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

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
          inherit pkgs;
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

      checks.${system}.pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          commitizen.enable = true;
          nixfmt.enable = true;
          stylua.enable = true;
        };
      };

      formatter.${system} =
        let
          config = self.checks.${system}.pre-commit-check.config;
          script = ''
            ${pkgs.lib.getExe config.package} run --all-files --config ${config.configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script;

      devShells.${system}.default =
        let
          pre-commit-check = self.checks.${system}.pre-commit-check;
        in
        pkgs.mkShell {
          shellHook = pre-commit-check.shellHook;
          buildInputs = pre-commit-check.enabledPackages;
          packages = [
            pkgs.lua51Packages.lua
          ];
        };
    };
}
