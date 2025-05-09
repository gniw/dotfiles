{ config, pkgs, lib, username, inputs, ... }:
let
  homeDirectory = if pkgs.stdenv.isDarwin then
    "/Users/${username}"
  else
    "/home/${username}"
  ;
  moralerspace = import ../fonts/moralerspace.nix {
    inherit (pkgs) stdenvNoCC fetchzip;
    inherit lib;
  };

  allPackages = pkgs.callPackage ../packages {};
  dotfiles = "~/.config";
in
{
  imports = [
    # import the home-manager module
    inputs._1password-shell-plugins.hmModules.default
    ./mcp-servers
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = lib.mkForce homeDirectory;

  # Packages that should be installed to the user profile.
  home.packages = allPackages;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;

  # Note that while the home-manager integration is recommended,
  # some use cases require the use of features only present in some versions of nix-direnv.
  # It is much harder to control the version of nix-direnv installed with this method.
  # If you require such specific control, please use another method of installing nix-direnv. 
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
    silent = true;
    enableNushellIntegration = true; # Whether to enable Nushell integration.
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      source ${dotfiles}/.bashrc
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs._1password-shell-plugins = {
    # enable 1Password shell plugins for bash, zsh, and fish shell
    enable = true;
    # the specified packages as well as 1Password CLI will be
    # automatically installed and configured to use shell plugins
    plugins = with pkgs; [ gh awscli2 cachix ];
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
