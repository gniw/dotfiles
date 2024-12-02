{ pkgs, lib, ... }:
	let
		cica = import ../fonts/cica.nix {
			inherit (pkgs) stdenvNoCC fetchzip;
			inherit lib;
		};
	in
{
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

  services.nix-daemon.enable = true;

	fonts = {
		packages = with pkgs; [
			cica
		];
	};

  system = {
    stateVersion = 5;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllFiles = true;
				AppleShowAllExtensions = true;
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
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    brews = [
    ];
    casks = [
			"wezterm"
    ];
  };
}
