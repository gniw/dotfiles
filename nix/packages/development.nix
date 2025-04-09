{ pkgs, ... }: with pkgs; [
# ----- lua -----
  lua-language-server
# ----- javascript -----
  deno
  nodejs
  bun
  biome
  typescript-language-server
]
