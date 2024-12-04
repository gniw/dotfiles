{ config, pkgs, lib, username, homeDirectory, dotfiles, ... }:
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
    # Nixpkgs has a simple `bash` for script/build cases, and a `bashInteractive` for human use.
    bashInteractive
    git
    gh
    ghq
    curl
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


  # Note that while the home-manager integration is recommended,
  # some use cases require the use of features only present in some versions of nix-direnv.
  # It is much harder to control the version of nix-direnv installed with this method.
  # If you require such specific control, please use another method of installing nix-direnv. 
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
    silent = true;
  };

  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile "${dotfiles}/.profile";
    bashrcExtra = builtins.readFile "${dotfiles}/.bashrc";
  };

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
