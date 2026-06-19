{ inputs, pkgs, ... }:
{
  imports = [
    ../mangohud.nix
  ];

  home.packages =
    let
      path = ../../../pkgs;
    in
    with pkgs;
    [
      (pkgs.callPackage (path + /dtkit-patch) { }) # for darktide mods
      inputs.switch-emulators.packages.${pkgs.stdenv.hostPlatform.system}.suyu
      # pyfa
      # pcsx2
      # rpcs3
      lutris
      # shadps4
      bottles
      etterna
      r2modman
      xivlauncher
      prismlauncher
      deadlock-mod-manager
      wineWow64Packages.stable
    ];
}
