{ ... }:
{
  systemd.network.wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    hostName = "pi";
    hosts = {
      "127.0.0.1" = [ "pi" ];
    };
    firewall.enable = true;
  };
}
