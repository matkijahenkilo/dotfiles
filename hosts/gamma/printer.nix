{ pkgs, ... }: {
  services = {
    printing = {
      enable = true;
      # drivers = [ pkgs.samsung-m2020w ]; # 💀
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