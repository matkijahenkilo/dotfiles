{ lib, pkgs, ... }:
let
  sounds-path = ../../assets/sounds;

  gsr-toggle-show = pkgs.writeShellScriptBin "gsr-toggle-show" ''
    gsr-ui-cli toggle-show
  '';

  gsr-toggle-record = pkgs.writeShellScriptBin "gsr-toggle-record" ''
    gsr-ui-cli toggle-record
    ${lib.getExe pkgs.mpv} ${sounds-path}/yume-nikki-jump2.wav
  '';

  gsr-toggle-replay = pkgs.writeShellScriptBin "gsr-toggle-replay" ''
    gsr-ui-cli toggle-replay
    ${lib.getExe pkgs.mpv} ${sounds-path}/yume-nikki-success2.wav
  '';

  gsr-replay-save = pkgs.writeShellScriptBin "gsr-replay-save" ''
    gsr-ui-cli replay-save
    ${lib.getExe pkgs.mpv} ${sounds-path}/yume-nikki-select2.wav
  '';

  gsr-reminder-on-startup = pkgs.writeShellScriptBin "gsr-reminder-on-startup" ''
    sleep 10 # wait for DE to fully start up
    gsr-notify --text 'Instant Replay on~ open menu with ALT+Z! (* ^ ω ^)' --timeout 6.0 --icon record
  '';

  path = ../../pkgs;

  gpu-screen-recorder-notification = pkgs.callPackage (
    path + /gpu-screen-recorder-ui/gpu-screen-recorder-notification.nix
  ) { };

  gpu-screen-recorder-ui = pkgs.callPackage (path + /gpu-screen-recorder-ui) {
    inherit gpu-screen-recorder-notification;
  };
in
{
  programs.gpu-screen-recorder.enable = true;
  environment.systemPackages = [
    gpu-screen-recorder-notification
    gpu-screen-recorder-ui
    gsr-toggle-show
    gsr-toggle-record
    gsr-toggle-replay
    gsr-replay-save
    gsr-reminder-on-startup
  ];
}
