{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        samsung-unified-linux-driver
        splix
      ];
      browsing = true;
      startWhenNeeded = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      settings = {
        publish = {
          disable-publishing = false;
          publish-addresses = true;
          disable-user-service-publishing = false;
        };
      };
    };
  };

  hardware.sane = {
    enable = true;
  };
}
