{ pkgs, ... }:
{
  imports = [
    ../yt-dlp.nix
    ../gallery-dl.nix
  ];

  home.packages = with pkgs; [
    ffmpeg-full
  ];
}
