{ ... }:
{
  systemd.network.wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    hostName = "xi";
    hosts = {
      "127.0.0.1" = [ "xi" ];
    };
    firewall.enable = true;
  };
}
