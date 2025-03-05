{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./networking.nix
    ./printer.nix
    ../../modules/nixos/users/gamma.nix
  ];

  system.stateVersion = "23.11";
}