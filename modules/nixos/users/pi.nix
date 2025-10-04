{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../groups/essentials.nix
    ../services/tsih-robo-ktx.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = lib.mkForce false;
    limine.enable = lib.mkForce false;
  };

  users.users.marisa.shell = lib.mkDefault pkgs.bash;

  environment.systemPackages = [
    inputs.tsih-robo-ktx.packages.aarch64-linux.default
  ];
}
