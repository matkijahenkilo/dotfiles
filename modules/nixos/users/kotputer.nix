{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/archivers.nix
    ../groups/desktop.nix
    ../groups/games.nix

    # gui
    ../sessions/plasma.nix
    ../stylix.nix

    # services
    ../gnupg-agent.nix
    ../zerotierone.nix
    ../services/palserver.nix

    # tools
    # ../virtualisation.nix

    # misc
    ../extra-users.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
