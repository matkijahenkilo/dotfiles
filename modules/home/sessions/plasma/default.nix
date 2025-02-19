{ pkgs, ... }: {
  imports = [
    ../xdg-portals.nix
    ../xdg-desktopEntries.nix
  ];

  home.packages = (with pkgs.kdePackages; [
    kalk
    bluedevil
    kdenlive
  ]) ++ (with pkgs; [
    wl-clipboard
  ]);
}