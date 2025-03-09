{ lib, pkgs, ... }:
let
  kf2server_path = "/media/WD/servers/KF2Server";
  kf2server_update = pkgs.writeShellScriptBin "kf2server_update" ''
    set -eo pipefail
    ${pkgs.steamcmd}/bin/steamcmd +force_install_dir ${kf2server_path} +login anonymous +app_update 232130 validate +quit
    [[ ! -a ~/.steam/sdk32 ]] && ln -s ~/.local/share/Steam/linux32 ~/.steam/sdk32
    [[ ! -a ~/.steam/sdk64 ]] && ln -s ~/.local/share/Steam/linux64 ~/.steam/sdk64
    exit 0
  '';
  steam-run-args = lib.concatStrings [
    "./Binaries/Win64/KFGameSteamServer.bin.x86_64 "
    "'"
    "KF-BurningParis"
    "?Mutator=UnofficialKFPatch.UKFPMutator"
    "?LinuxCrashHack=1"
    "?BroadcastPickups=1"
    "?DisableTraderLocking=1"
    "?DropAllWepsOnDeath=1"
    "?NoEDARs=1"
    " -AdminName=nanako"
    "'"
  ];
in {
  systemd.services = {
    # Main server service
    kf2server = {
      unitConfig = {
        Description = "Killing Floor 2 Server";
        Documentation = [ "https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)" ];
      };

      serviceConfig = {
        WorkingDirectory = kf2server_path;
        ExecStart = "${pkgs.steam-run}/bin/steam-run ${steam-run-args}";
        Restart = "always";
        RestartSec = "15s";
      };
    };

    # Manual update service
    kf2server-update = {
      unitConfig = {
        Description = "Killing Floor 2 Server Update";
        Documentation = [ "https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)" ];
      };

      serviceConfig = {
        Type = "oneshot";
        WorkingDirectory = kf2server_path;
        ExecStart = "${kf2server_update}/bin/kf2server_update";
      };
    };
  };

  # if your isp absolutely stinks and you prefer to use zerotier-one,
  # friends can connect to the host with console command "open [zerotier ip]"
  # as the server won't appear in LAN tab...............,,,,,,,,,;;..,
  networking.firewall.allowedUDPPorts = [
    7777  # main game port
    20560 # Steam Port
    123   # ntp for weekly outbreaks
  ];

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true; # allows 27015 - the query port, used to communicate with the Steam Master Server
  };
}