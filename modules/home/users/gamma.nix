{ pkgs, libs, ... }:
{
  home = {
    username = "marisa";
    homeDirectory = "/home/marisa";
    stateVersion = "23.11";
  };

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
