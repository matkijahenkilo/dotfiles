{ lib, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../services/tsih-robo-ktx.nix
    ../radicale.nix
  ];

  environment.systemPackages = with pkgs; [
    libraspberrypi # can't use raspi-utils yet because flake it not updated
  ];

  # override configs for the raspberry pi host
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.limine.enable = lib.mkForce false;
  i18n.extraLocales = lib.mkForce [ ];
}
