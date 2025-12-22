{ ... }:
{
  networking = {
    hostName = "pi";
    hosts = {
      "127.0.0.1" = [ "pi" ];
    };
    firewall.enable = true;
  };
}
