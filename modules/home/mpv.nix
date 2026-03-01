{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      geometry = "1280x720";
      gpu-api = "vulkan";
      hwdec = "auto";
      keep-open = "no";
      profile = "high-quality";
      save-position-on-quit = "yes";
      target-colorspace-hint = "no";
      vo = "gpu-next";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      sponsorblock
      webtorrent-mpv-hook
    ];
  };
}
