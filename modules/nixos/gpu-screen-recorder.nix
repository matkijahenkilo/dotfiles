{ pkgs, ... }:
let
  gpu-screen-recorder-save-replay = pkgs.writeShellScriptBin "gpu-screen-recorder-save-replay" ''
    ${pkgs.killall}/bin/killall -SIGUSR1 gpu-screen-recorder
    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/music4.WAV
  '';
in {
  programs.gpu-screen-recorder.enable = true;
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gpu-screen-recorder-save-replay
  ];
}