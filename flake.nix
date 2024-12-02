{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
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
    system = "aarch64-darwin";
    overlays = [
      neovim-nightly-overlay.overlays.default
    ];
    pkgs = import nixpkgs { inherit overlays system; };
  in
  {

    apps.${system} = {
      update = {
        type = "app";
        program = toString(
          pkgs.writeShellScript "update-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating home-manager..."
            nix run nixpkgs#home-manager -- switch --flake .#home-manager
            echo "Updating nix-darwin..."
            nix run nix-darwin -- switch --flake .#nix-darwin
            echo "Update complete!"
          ''
        );
      };

      update-home = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "update-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating home-manager..."
            nix run nixpkgs#home-manager -- switch --flake .#home-manager
            echo "Update complete!"
          ''
        );
      };

      update-darwin = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "update-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating nix-darwin..."
            nix run nix-darwin -- switch --flake .#nix-darwin
            echo "Update complete!"
          ''
        );
      };
    };

    homeConfigurations = {
      home-manager = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./nix/home-manager/default.nix
        ];
      };
    };

    darwinConfigurations = {
      nix-darwin = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [ ./nix/nix-darwin/default.nix ];
      };
    };
  };
}

# update:
#   nix run .#update (all)
#   nix run .#update-home
#   nix run .#update-darwin
