{ pkgs, config, lib, mcp-servers-nix, ... }:
let
  # passCmd= pkgs.writeScript "passcmd" ''
  #   gh auth token
  # '';
  mcpSeversConfig = mcp-servers-nix.lib.mkConfig pkgs
    {
      programs = {
        filesystem = {
          enable = true;
          args = [
            "${config.home.homeDirectory}/ghq/github.com/super-studio"
            "${config.home.homeDirectory}/ghq/github.com/gniw/dotfiles"
          ];
        };
        fetch.enable = true;
        playwright.enable = true;
        git.enable = true;
        # github = {
        #   enable = true;
        #   passwordCommand = {
        #     GITHUB_PERSONAL_ACCESS_TOKEN = [ "${passCmd}" ];
        #   };
        # };
      };
    };
in
{
  home.file = {
    "${config.xdg.configHome}/mcphub/servers.json".source = mcpSeversConfig;
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # for claude desktop
    "Library/Application\ Support/Claude/claude_desktop_config.json".source = mcpSeversConfig;
  };
}
