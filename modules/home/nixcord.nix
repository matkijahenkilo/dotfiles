# https://github.com/KaylorBen/nixcord
{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];
  home.sessionVariables.NIXOS_OZONE_WL = "1";
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
        fakeNitro.enable = true;
        noF1.enable = true;
        alwaysAnimate.enable = true;
        favoriteGifSearch.enable = true;
        whoReacted.enable = true;
        callTimer.enable = true;
        petpet.enable = true;
      };
    };
  };

  home.packages = [
    (pkgs.callPackage (../../pkgs/krisp-patcher) { })
  ];
}
