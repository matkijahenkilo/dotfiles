{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/desktop.nix
    ../groups/games.nix
    ../sessions/plasma.nix

    ../gnupg-agent.nix
    ../zerotierone.nix
  ];
}
