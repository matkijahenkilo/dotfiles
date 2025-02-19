{ pkgs, ... }: {
  imports = [
    ../mangohud.nix
  ];

  home.packages = (
  let
    path = ../../../pkgs;
  in
  let
    dtkit-patch = pkgs.callPackage (path + /dtkit-patch) { };
  in [
    dtkit-patch
  ]) ++ (with pkgs; [
    suyu
    wine
    pyfa
    lutris
    bottles
    r2modman
    archipelago
    xivlauncher
  ]);
}