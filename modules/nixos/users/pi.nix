{ lib, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../services/tsih-robo-ktx.nix
    ../radicale.nix
  ];

  # override configs for the raspberry pi host
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.limine.enable = lib.mkForce false;
  i18n.extraLocales = lib.mkForce [ ];

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 20;
  };
}
