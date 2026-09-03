{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      # obs-shaderfilter # currently broken and I don't use it that much
      droidcam-obs
    ];
  };
}
