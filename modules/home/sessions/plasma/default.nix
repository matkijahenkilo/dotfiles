{ pkgs, ... }: {
  imports = [
    ../xdg-portals.nix
    ../xdg-desktopEntries.nix
  ];

  home.packages = (with pkgs.kdePackages; [
    bluedevil
    kalk
    ktimer
  ]) ++ (with pkgs; [
    wl-clipboard
    strawberry
  ]);
}