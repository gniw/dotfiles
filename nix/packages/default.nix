{ pkgs, ... }:
# The return value of `callPackage` is a list like [nodejs deno ...],
# and the return value of `map` is a list of lists like [ [nodejs deno] [curl git] ...],
# so flattening with `concatLists`` is necessary
builtins.concatLists (map (file: pkgs.callPackage file {}) [
  ./commands.nix
  ./development.nix
  ./docker.nix
  ./fonts.nix
  ./shell.nix
  ./tools.nix
])
