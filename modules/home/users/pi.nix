{ pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/cli.nix
    ../fastfetch.nix
  ];

  # dependencies for discord bot
  home.packages = with pkgs; [
    jdk21
    gallery-dl
    yt-dlp
    ffmpeg
  ];
}
