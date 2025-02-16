{ pkgs, ... }: {
  imports = [
    ../xdg.nix
  ];

  home.packages = with pkgs.kdePackages; [
    kalk
    bluedevil
  ];
}