{ ... }:
{
  systemd.network.wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    hostName = "quirera";
    hosts = {
      "127.0.0.1" = [ "quirera" ];
    };
    firewall.enable = true;
  };
}
