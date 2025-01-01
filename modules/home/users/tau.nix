{ pkgs, ... }: {
  imports = [
    ../nix.nix
    ../git.nix
    ../micro.nix
    ../kitty.nix
    ../zsh.nix
    ../fastfetch.nix
    ../syncthing.nix
  ];
}
