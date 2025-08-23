{ lib, pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;

    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
      warn-dirty = false;
      auto-optimise-store = lib.mkDefault true;
      max-jobs = "auto";
      cores = 0;
      download-buffer-size = 8000000000; # 8 GB
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
