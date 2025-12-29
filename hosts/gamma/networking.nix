{ ... }:
{
  systemd.network.wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    hostName = "gamma";
    hosts = {
      "127.0.0.1" = [ "gamma" ];
    };
    firewall.enable = true;
  };
}
