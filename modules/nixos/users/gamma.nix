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
    ../zabbix.nix

    ../services/palserver.nix

    ../virtualisation.nix
    # ../virtualisation.nix
    # ../davinci-resolve-studio.nix
    ../alvr.nix
    ../llama-cpp.nix
    ../sunshine.nix
  ];

  zabbix = {
    agent.enable = false; # don car bout my own pc
    web.enable = true;
  };

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  environment.systemPackages = with pkgs; [
    android-tools
  ];

  users.users.marisa.extraGroups = [
    "adbusers"
    "kvm"
  ];
}
