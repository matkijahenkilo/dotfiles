{ inputs, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix
  ];

  # dependencies for discord bot
  home.packages = with pkgs; [
    inputs.tsih-robo-ktx.packages.aarch64-linux.default
    ffmpeg
  ];
}
