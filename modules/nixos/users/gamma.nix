{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/archivers.nix
    ../groups/desktop.nix
    ../groups/games.nix

    ../sessions/plasma.nix
    ../stylix.nix

    ../zerotierone.nix
    ../gnupg-agent.nix
    ../docker.nix

    ../services/kf2-server.nix
    ../services/minecraft-server.nix
    ../services/palserver.nix
    ../llm.nix
    ../virtualization.nix
    ../davinci-resolve-studio.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  programs.adb.enable = true;
  users.users.marisa.extraGroups = [
    "adbusers"
    "kvm"
  ];
}
