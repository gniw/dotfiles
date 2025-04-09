{ config, pkgs, lib, inputs, username, homeDirectory,... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = [ pkgs.nodejs ];

  # make no effect??
  environment.shells = [ pkgs.bash ];

  # user settings
  users.users.${username} = with pkgs; {
    shell = bashInteractive;
    packages = [
      coreutils
    ];
  };

  # nix-darwin での基本的な環境変数設定
  launchd.user.envVariables = {
    HOME = homeDirectory;
    USER = username;
    # https://github.com/nix-darwin/nix-darwin/issues/406#issuecomment-2759999399
    # PATH = builtins.replaceStrings
    #   [
    #     "$HOME"
    #     "$USER"
    #   ]
    #   [
    #     homeDirectory
    #     username
    #   ]
    #   config.environment.systemPath;
  };

  # nix
  nix = {
    gc = {
      automatic = true;
      interval = {
        Hour = 9;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
    };
  };

  # system
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      _HIHideMenuBar = true;
    };
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };
    dock = {
      autohide = true;
      show-recents = false;
      orientation = "right";
    };
  };

  # fonts
	fonts.packages = with pkgs; [
  ];

  # homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
    };
  };

  homebrew.brews = [];
  homebrew.casks = [
    "wezterm"
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # The configuration of the Nix Packages collection. (For details, see the Nixpkgs documentation.)
  nixpkgs.config = { allowUnfree = true; };
}
