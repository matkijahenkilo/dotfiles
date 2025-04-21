{ lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "generic";
    firewall.enable = true;
  };

  system.stateVersion = "23.11";
}