{ pkgs, ... }:
let
  flameshot-fast-ss = pkgs.writeShellScriptBin "flameshot-fast-ss" ''
    year=''$(date +"%Y")
    month=''$(date +"%m")
    day=''$(date +"%d")

    filepath=(~/Pictures/screenshots/''$year-''$month)

    mkdir -p ''$filepath

    flameshot gui --accept-on-select -c -p ''$filepath

    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/footstep.WAV
  '';

  flameshot-full-ss = pkgs.writeShellScriptBin "flameshot-full-ss" ''
    year=''$(date +"%Y")
    month=''$(date +"%m")
    day=''$(date +"%d")

    filepath=(~/Pictures/screenshots/''$year-''$month)

    mkdir -p ''$filepath

    flameshot full -c -p ''$filepath

    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/footstep.WAV
  '';
in {
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        contrastOpacity = 188;
        filenamePattern = "%F_%T";
        disabledGrimWarning = true;
        showStartupLaunchMessage = false;
        showDesktopNotification = false;
      };
    };
  };

  home.packages = [
    flameshot-fast-ss
    flameshot-full-ss
  ];
}