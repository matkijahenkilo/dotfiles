# https://github.com/KaylorBen/nixcord
{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];
  programs.nixcord = {
    enable = true;
    discord = {
      enable = true;
      branch = "stable";
      openASAR.enable = true;
      autoscroll.enable = true;
      vencord.enable = true;
    };
    config = {
      frameless = false;
      plugins = {
        youtubeAdblock.enable = true;
      };
    };
  };

  home.packages = [
    (pkgs.callPackage (../../pkgs + /krisp-patcher) { })
  ];
}
