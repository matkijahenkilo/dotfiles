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
      (pkgs.callPackage (path + /KF2ServerToolCMD) { }) # for configuring KF2 servers
      (pkgs.writeShellScriptBin "KF2ServerToolCMD-run-annoying-batch-of-commands" ''
        KF2ServerToolCMD -addmod 'https://steamcommunity.com/sharedfiles/filedetails/?id=2875147606'
        KF2ServerToolCMD -addmod 'https://steamcommunity.com/sharedfiles/filedetails/?id=1819268190'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=3614785677'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=650252240'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=1987388527'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=1752398772'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=1774649072'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=1893143023'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=645410401'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=1208883070'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=900540985'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=682290186'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=733191110'
        KF2ServerToolCMD -addmap 'https://steamcommunity.com/sharedfiles/filedetails/?id=643269874'
      '')
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
