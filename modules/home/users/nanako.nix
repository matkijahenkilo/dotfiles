{ pkgs, ... }:
{
  home = {
    username = "nanako";
    homeDirectory = "/home/nanako";
    stateVersion = "23.11";
  };

  imports = [
    ../groups/essentials.nix

    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix

    ../groups/gui.nix
    ../groups/games.nix
    ../sessions/plasma
    ../fcitx5.nix

    ../idea.nix
  ];
}
