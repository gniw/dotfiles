# common-claude.nix
{ config, pkgs, ... }:

{
  # NodeJSのみをインストール（npmは自動的に含まれます）
  home.packages = with pkgs; [
    nodejs
  ];

  # 環境変数
  home.sessionVariables = {
    # NODE_PATHはNodeモジュールの検索パスを設定
    NODE_PATH = "${pkgs.nodejs}/lib/node_modules";
    # 必要に応じてnpmのグローバルプレフィックスを設定
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };

  # シェルエイリアス - NodeJSのバイナリパスのみを追加
  programs.bash.shellAliases = {
    "claude" = "PATH=$PATH:${pkgs.nodejs}/bin claude-desktop";
  };
  
  programs.zsh.shellAliases = {
    "claude" = "PATH=$PATH:${pkgs.nodejs}/bin claude-desktop";
  };
}
