{ pkgs, ... }: {
  imports = [
    ../groups/essentials.nix
    ../syncthing.nix

    ../groups/cli.nix
    ../fastfetch.nix

    ../groups/gui.nix
    ../fcitx5.nix
  ];
}