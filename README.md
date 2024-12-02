## Requirements

1. Clone this repository
```sh
git clone gniw/dotfiles
```

2. Run nix installer (if you haven't installed Nix yet!)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

3. Create Home environment
```sh
nix run nixpkgs#home-manager -- switch --flake .#home-manager
```

That's it! :)
> [!NOTE]
> Currently, only aarch64-darwin is supported.
