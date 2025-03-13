{ pkgs, ... }: {
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
      publish.enable = true;
      publish.addresses = true;
      publish.userServices = true;
    };
  };

  hardware.sane = {
    enable = true;
  };
}