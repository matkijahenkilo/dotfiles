{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./networking.nix
    ./printer.nix
    ../../modules/nixos/users/xi.nix
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  system.stateVersion = "23.11";
}
