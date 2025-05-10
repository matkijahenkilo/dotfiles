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
    dtkit-patch # for darktide mods
  ]) ++ (with pkgs; [
    suyu
    wine
    pyfa
    lutris
    bottles
    etterna
    r2modman
    archipelago
    xivlauncher
    prismlauncher
  ]);
}