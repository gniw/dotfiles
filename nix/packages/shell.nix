{ pkgs, ... }: with pkgs; [
  # Nixpkgs has a simple `bash` for script/build cases, and a `bashInteractive` for human use.
  bashInteractive
  nushell
]
