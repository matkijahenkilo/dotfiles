{ pkgs, ... }:
{
  imports = [
    ../xdg-portals.nix
    ../../flameshot.nix
  ];

  home.packages =
    (with pkgs.kdePackages; [
      bluedevil
      kalk
      ktimer
      filelight
    ])
    ++ (with pkgs; [
      wl-clipboard
      strawberry
    ]);
}
