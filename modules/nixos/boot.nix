{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
