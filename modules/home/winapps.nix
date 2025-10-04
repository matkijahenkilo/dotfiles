# requires creating some files manually
# https://github.com/winapps-org/winapps
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.winapps.packages."x86_64-linux".winapps
    inputs.winapps.packages."x86_64-linux".winapps-launcher
    pkgs.podman-compose
    pkgs.freerdp
  ];

  # https://github.com/winapps-org/winapps/blob/main/docs/docker.md
  # For rootless podman to work, you need to add your user
  # to the kvm group to be able to access /dev/kvm.
  services.podman.enable = true;
}
