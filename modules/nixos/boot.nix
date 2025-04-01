{ lib, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine.enable = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };
}