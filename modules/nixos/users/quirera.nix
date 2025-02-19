{ config, pkgs, ... }: {
  imports = [
    ../groups/essentials.nix
    ../groups/desktop.nix
    ../groups/games.nix

    ../gnupg-agent.nix
    ../zerotierone.nix
  ];

  services.desktopManager.plasma6.enable = true;
}