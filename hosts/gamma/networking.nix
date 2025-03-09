{ ... }: {
  networking = {
    networkmanager.enable = true;
    hostName = "gamma";
    hosts = {
      "127.0.0.1" = [ "gamma" ];
    };
    firewall = {
      enable = true;
      allowedUDPPorts = [
        # kf2
        7777
        27015
        20560
        123
      ];
    };
  };
}