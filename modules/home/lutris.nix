{ pkgs, ... }:
{
  programs.lutris = {
    enable = true;
    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
