{ config, pkgs, lib, username, homeDirectory, ... }:
let
  moralerspace = import ../fonts/moralerspace.nix {
    inherit (pkgs) stdenvNoCC fetchzip;
    inherit lib;
  };
  allPackages = pkgs.callPackage ../packages {};
  dotfiles = "~/.config";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = lib.mkForce homeDirectory;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  # ----- nix -----
    nix-search-cli
  # ----- shell -----
    # Nixpkgs has a simple `bash` for script/build cases, and a `bashInteractive` for human use.
    bashInteractive
    nushell
  # ----- command -----
    git
    gh
    ghq
    curl
    ripgrep
    fd
    fzf
    bat
    unar
  # ----- docker -----
    docker
    docker-compose
    colima
  # ----- tools -----
    neovim
    wezterm
    lazygit
    direnv
    nix-direnv
    markdownlint-cli2
  # ----- font -----
    moralerspace
  # ----- dev -----
    claude-code
  # ----- lua -----
    lua-language-server
  # ----- javascript -----
    deno
    nodejs
    bun
    biome
    typescript-language-server
  ];

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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # home.file allows you to declaratively manage files in your home directory
  # Each attribute creates a file at the specified path (relative to $HOME)
  # You can specify file content directly with 'text', source from another file with 'source',
  # or create symlinks with 'target'
  home.file = lib.mkIf pkgs.stdenv.isDarwin {
    # Create a Claude wrapper in the user's Applications directory that includes Node.js
    "Applications/Claude with Node.app/Contents/MacOS/Claude with Node" = {
      text = ''
        #!/bin/bash
        export PATH="${pkgs.nodejs}/bin:$PATH"
        /Applications/Claude.app/Contents/MacOS/Claude "$@"
      '';
      executable = true;  # Make the file executable
    };
    
    # Create Info.plist file for the claude wrapper app
    "applications/claude with node.app/contents/info.plist" = {
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>CFBundleExecutable</key>
          <string>Claude with Node</string>
          <key>CFBundleIdentifier</key>
          <string>com.user.claude-with-node</string>
          <key>CFBundleName</key>
          <string>Claude with Node</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>CFBundleVersion</key>
          <string>1.0</string>
          <key>CFBundleIconFile</key>
          <string>electron.icns</string>
        </dict>
        </plist>
      '';
    };
  };

  # Execute command to set the icon (only on macOS)
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyClaudeIcon = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ~/Applications/Claude\ with\ Node.app/Contents/Resources/
      if [ -f /Applications/Claude.app/Contents/Resources/electron.icns ]; then
        cp /Applications/Claude.app/Contents/Resources/electron.icns ~/Applications/Claude\ with\ Node.app/Contents/Resources/
        # Set appropriate permissions for the icon file
        chmod 644 ~/Applications/Claude\ with\ Node.app/Contents/Resources/electron.icns
        # Set appropriate permissions for the app directory
        chmod -R 755 ~/Applications/Claude\ with\ Node.app
        # Clear icon cache
        touch ~/Applications/Claude\ with\ Node.app
      fi
    '';
  };
}
