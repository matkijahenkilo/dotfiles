{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/archivers.nix
    ../groups/desktop.nix
    ../groups/games.nix
    ../sessions/plasma.nix

    ../gnupg-agent.nix
    ../zerotierone.nix

    ../extra-users.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];
}
