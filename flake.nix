{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    neovim-nightly-overlay,
    home-manager,
    mcp-servers-nix,
    ...
  } @inputs :
  let
    # ----------------------------------------------
    #   nix settings
    # ----------------------------------------------
    overlays = [
      neovim-nightly-overlay.overlays.default
      mcp-servers-nix.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
    dotfiles = ./.config;

    users = [
      {
        system = "aarch64-darwin";
        username = "tsubasa.yamamoto";
        hostname = "SS0198";
      }
      {
        system = "x86_64-linux";
        username = "wing";
        hostname = "archlinux";
      }
    ];

    supportedSystems = (attrSets: key:
      let
        # 各属性セットから特定のキーの値を取得（存在する場合のみ）
        values = builtins.map
          (set: if builtins.hasAttr key set then [set.${key}] else [])
          attrSets;

        # リストのリストをフラット化する
        concatLists = builtins.concatLists values;
      in
      nixpkgs.lib.unique concatLists
    ) users "system";

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    makeHomeManagerConfig = configList: map(cfg:
      let
        inherit (cfg) system username hostname;
        pkgs = import nixpkgs { inherit system overlays config; };
      in
      {
        name = "${username}@${hostname}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username mcp-servers-nix inputs;
          };
          modules = [
            ./nix/home-manager/home.nix
          ];
        };
      }) configList;
  in
  {
    homeConfigurations = builtins.listToAttrs(makeHomeManagerConfig users);
  
    apps = forAllSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        "update" = {
          type = "app";
          program = toString (
            pkgs.writeShellScript "update-script" ''
              set -e
              echo "Updating flake..."
              nix flake update
            ''
          );
        };
        "rebuild" = {
          type = "app";
          program = toString (
            pkgs.writeShellScript "rebuild-script" ''
              set -e
              echo "Rebuild home-manager..."
              nix run nixpkgs#home-manager -- switch --flake .
              echo "home-manager Rebuild complete!"
            ''
          );
        };
      }
    );

  };
}
