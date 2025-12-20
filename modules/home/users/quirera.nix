{ pkgs, ... }:
{
  home = {
    username = "marisa";
    homeDirectory = "/home/marisa";
    stateVersion = "23.11";
  };

  imports = [
    ../groups/essentials.nix
    ../syncthing.nix

    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix

    ../groups/gui.nix
    ../groups/games.nix
    ../sessions/plasma
    ../fcitx5.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-oss
  ];
}
