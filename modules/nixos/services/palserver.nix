# https://github.com/rafaelrc7/dotfiles/blob/0a9a2a7b666a2843015402ec12d78864b48fd9e3/modules/nixos/palserver.nix

{
  lib,
  pkgs,
  config,
  ...
}:
let
  palserver_path = "/var/lib/palworld";
  palserver_workingDir = "${palserver_path}/.local/share/Steam/Steamapps/common/PalServer";
  palserver_update = pkgs.writeShellScriptBin "palserver_update" ''
    set -eo pipefail
    ${lib.getExe pkgs.steamcmd} +login anonymous +app_update 2394010 validate +quit
    [[ ! -e ~/.steam/sdk32 ]] && ln -s ~/.local/share/Steam/linux32 ~/.steam/sdk32
    [[ ! -e ~/.steam/sdk64 ]] && ln -s ~/.local/share/Steam/linux64 ~/.steam/sdk64
    exit 0
  '';
  palserver_start = pkgs.writeShellScriptBin "palserver_start" ''
    [[ ! -d ${palserver_workingDir} ]] && mkdir ${palserver_workingDir}
    cd ${palserver_workingDir}
    ${lib.getExe pkgs.steam-run} ./PalServer.sh -publicport=8211 -port=8211 -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDs
    exit 0
  '';
in
{
  networking.firewall = {
    allowedTCPPorts = [
      25575 # RCON
    ];
    allowedUDPPorts = [
      8211 # PalWorld
    ];
  };

  users.users.palworld = {
    isSystemUser = true;
    home = palserver_path;
    createHome = true;
    group = "palworld";
    shell = "${pkgs.shadow}/bin/nologin";
  };

  users.groups.palworld = {
    gid = config.users.users.palworld.uid;
  };

  systemd.services = {
    palserver = {
      unitConfig = {
        Description = "PalWorld Server";
        Documentation = [ "https://tech.palworldgame.com/dedicated-server-guide" ];
      };

      serviceConfig = {
        User = "palworld";
        Group = "palworld";
        ExecStartPre = "${lib.getExe palserver_update}";
        ExecStart = "${lib.getExe palserver_start}";
        Restart = "always";
        RestartSec = "15s";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
