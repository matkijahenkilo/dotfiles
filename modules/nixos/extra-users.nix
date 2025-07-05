{ lib, pkgs, ... }:
{
  users.users.nanako = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = lib.mkForce "$y$j9T$furlO9PD2uaSqLQPmFhe2.$7J4/hdgt9ZQEgeYNB15Tm.zOs8As5FQrjYgjA.qm8AC";
  };
}
