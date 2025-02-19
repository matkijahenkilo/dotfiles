{ lib, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };
}
