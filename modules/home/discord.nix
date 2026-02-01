{ inputs, pkgs, ... }:
{
  # https://github.com/FlameFlag/nixcord
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord = {
      enable = true;
      vencord.enable = true;
      branch = "stable";
      autoscroll.enable = true;
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
        readAllNotificationsButton.enable = true;
        ClearURLs.enable = true;
      };
    };
  };

  home.packages = [
    (pkgs.callPackage (../../pkgs/krisp-patcher) { })
  ];
}
