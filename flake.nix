{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    neovim-nightly-overlay,
    home-manager,
    nix-darwin,
    ...
  } @inputs :
  let
    overlays = [
      neovim-nightly-overlay.overlays.default
    ];
  in
  {
    # ----------------------------------------------
    #   linux
    # ----------------------------------------------
    homeConfigurations = {
      "wing@archlinux" = let 
        system = "x86_64-linux";
        username = "wing";
        hostname = "archlinux";
        homeDirectory = "/home/${username}";
        pkgs = import nixpkgs { inherit system overlays; };
      in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs username homeDirectory;
        };
        modules = [
          ./nix/home-manager/home.nix
        ];
      };
    };
    apps.x86_64-linux = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      update = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "install-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Installing nix-darwin..."
            nix run nixpkgs#home-manager -- switch --flake .
            echo "home-manager Install complete!"
          ''
        );
      };
    };

    # ----------------------------------------------
    #   aarch64-darwin
    # ----------------------------------------------
    apps.aarch64-darwin = let
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
    in {
      install = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "install-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Installing nix-darwin..."
            nix run nix-darwin -- switch --flake .
            echo "nix-darwin Install complete!"
          ''
        );
      };
      update = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "install-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating nix-darwin..."
            darwin-rebuild switch --flake .
            echo "nix-darwin Update complete!"
          ''
        );
      };
    };

    darwinConfigurations = let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system overlays; };
      inherit (import ./nix/nix-darwin/user.nix) username hostname homeDirectory;
    in {
      ${hostname} = nix-darwin.lib.darwinSystem {
        inherit system pkgs;
        modules = [
          ./nix/nix-darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./nix/home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit username homeDirectory; };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}

# update:
#   nix run .#update (all)
#   nix run .#update-home
#   nix run .#update-darwin
