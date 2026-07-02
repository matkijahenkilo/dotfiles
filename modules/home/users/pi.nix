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

  zsh.ffmpegFunctions.enable = false;

  home.packages = with pkgs; [
    btop
  ];
}
