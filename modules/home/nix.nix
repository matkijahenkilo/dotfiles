{ pkgs, lib, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
      max-jobs = "auto";
      cores = 0;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
