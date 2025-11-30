{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/archivers.nix
    ../groups/desktop.nix
    ../groups/games.nix

    ../sessions/plasma.nix
    ../stylix.nix

    ../gnupg-agent.nix
    ../zerotierone.nix

    ../services/palserver.nix

    ../extra-users.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];
}
