{ config, pkgs, lib, username, homeDirectory, ... }:
let
  cica = import ../fonts/cica.nix {
    inherit (pkgs) stdenvNoCC fetchzip;
    inherit lib;
  };
in
{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = lib.mkForce homeDirectory;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    git
    curl
    ghq
    neovim
    wezterm
    lazygit
    nix-search-cli
    ripgrep
    fzf
    bat
    direnv
    nix-direnv
    unar
    cica
  ];

  # Unfree packages (why `nixpkgs.config.allowUnfree` is ignored??)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
