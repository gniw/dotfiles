{ pkgs, ... }: with pkgs; [
# ----- General purpose Language Server that integrate with linter to support diagnostic features -----
  diagnostic-languageserver
  efm-langserver
# ----- HTML/CSS/JSON/ESLint language servers extracted from vscode -----
  vscode-langservers-extracted
# ----- lua -----
  lua-language-server
# ----- javascript -----
  deno
  nodejs
  bun
  biome
  typescript-language-server
]
