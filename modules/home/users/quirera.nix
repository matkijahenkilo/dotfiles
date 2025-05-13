{ pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../syncthing.nix

    ../groups/cli.nix
    ../fastfetch.nix

    ../groups/gui.nix
    ../groups/games.nix
    ../sessions/plasma
    ../fcitx5.nix

    ../idea.nix
  ];
}
