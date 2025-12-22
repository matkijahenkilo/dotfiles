{ pkgs, ... }:
{
  home = {
    username = "marisa";
    homeDirectory = "/home/marisa";
    stateVersion = "23.11";
  };

  imports = [
    ../groups/essentials.nix
    ../groups/cli.nix
    ../fastfetch.nix
    ../syncthing.nix
  ];

  home.packages = with pkgs; [
    btop
  ];
}
