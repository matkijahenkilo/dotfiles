{ pkgs, libs, ... }:
{
  imports = [
    ../groups/essentials.nix

    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix
    ../syncthing.nix
    ../gschemas.nix

    ../groups/gui.nix
    ../sessions/plasma
    ../groups/games.nix
    ../fcitx5.nix
    ../idea.nix
  ];

  home.packages = with pkgs; [
    dbeaver-bin
  ];
}
