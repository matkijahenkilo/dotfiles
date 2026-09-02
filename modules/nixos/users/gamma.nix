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
    ../zerotierone.nix
    ../gnupg-agent.nix
    ../zabbix.nix

    # tools
    # ../davinci-resolve-studio.nix
    ../docker.nix
    ../virtualisation.nix
    ../alvr.nix
    ../llama-cpp.nix
    ../sunshine.nix
    ../android-tools.nix
    ../qemu.nix
  ];

  zabbix = {
    agent.enable = false; # don car bout my own pc
    web.enable = true;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
