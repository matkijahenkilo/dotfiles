{ pkgs, ... }: {
  imports = [
    ../xdg-portals.nix
    ../xdg-desktopEntries.nix
  ];

  home.packages = (with pkgs.kdePackages; [
    kalk
    bluedevil
  ]) ++ (with pkgs; [
    wl-clipboard
  ]);
}