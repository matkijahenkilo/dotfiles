{ pkgs, ... }: {
  imports = [
    ../groups/essentials.nix
    ../syncthing.nix

    ../groups/cli.nix
    ../fastfetch.nix

    ../groups/gui.nix
    ../sessions/plasma
    ../fcitx5.nix
  ];
}