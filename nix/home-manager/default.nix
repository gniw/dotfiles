{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (import ./options.nix) username homeDirectory;
in {
  nixpkgs.config.allowUnfree = true;
  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";
    packages = with pkgs;
    [
      git
      curl
      ghq
      neovim
      wezterm
      lazygit
      unrar
      nix-search-cli
      ripgrep
      fzf
      bat
      direnv
      nix-direnv
    ];
  };
  programs.home-manager.enable = true;
} 
