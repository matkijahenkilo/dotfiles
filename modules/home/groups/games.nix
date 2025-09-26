{ inputs, pkgs, ... }:
{
  imports = [
    ../mangohud.nix
  ];

  home.packages =
    (
      let
        path = ../../../pkgs;
      in
      let
        dtkit-patch = pkgs.callPackage (path + /dtkit-patch) { };
      in
      [
        dtkit-patch # for darktide mods
      ]
    )
    ++ (with pkgs; [
      inputs.switch-emulators.packages."x86_64-linux".suyu
      wine
      pyfa
      pcsx2
      rpcs3
      lutris
      shadps4
      bottles
      etterna
      r2modman
      archipelago
      xivlauncher
      prismlauncher
    ]);
}
