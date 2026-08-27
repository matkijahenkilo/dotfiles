{ ... }:
{
  systemd.network.wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    hostName = "kotputer";
    hosts = {
      "127.0.0.1" = [ "kotputer" ];
    };
    firewall.enable = true;
  };
}
