{ pkgs, ... }:
let
  gsr-toggle-show = pkgs.writeShellScriptBin "gsr-toggle-show" ''
    gsr-ui-cli toggle-show
  '';

  gsr-toggle-record = pkgs.writeShellScriptBin "gsr-toggle-record" ''
    gsr-ui-cli toggle-record
    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/jump2.wav
  '';

  gsr-toggle-replay = pkgs.writeShellScriptBin "gsr-toggle-replay" ''
    gsr-ui-cli toggle-replay
    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/success2.WAV
  '';

  gsr-replay-save = pkgs.writeShellScriptBin "gsr-replay-save" ''
    gsr-ui-cli replay-save
    ${pkgs.mpv}/bin/mpv ~/Documents/sounds/select2.WAV
  '';

  path = ../../pkgs;
  notification = pkgs.callPackage (path + /gpu-screen-recorder-ui/gpu-screen-recorder-notification.nix) { };
in {
  programs.gpu-screen-recorder.enable = true;
  environment.systemPackages = (
  let
    gpu-screen-recorder-ui = pkgs.callPackage (path + /gpu-screen-recorder-ui) {
      gpu-screen-recorder-notification = notification;
    };
    gpu-screen-recorder-notification = notification;
  in [
    gpu-screen-recorder-ui
    gpu-screen-recorder-notification
  ]) ++ (with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gsr-toggle-show
    gsr-toggle-record
    gsr-toggle-replay
    gsr-replay-save
  ]);
}