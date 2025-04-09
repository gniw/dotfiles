{ pkgs, lib, ... }:
let
  moralerspace = import ../fonts/moralerspace.nix {
    inherit (pkgs) stdenvNoCC fetchzip;
    inherit lib;
  };
in
with pkgs; [
  moralerspace
]

