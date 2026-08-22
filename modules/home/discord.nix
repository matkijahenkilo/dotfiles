{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  # https://github.com/4evy/nixcord
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord = {
      equicord.enable = true;
      vencord.enable = false;
      branches  = [ "stable" ];
      krisp.enable = true;
      commandLineArgs = [
        "--enable-blink-features=MiddleClickAutoscroll"
      ];
    };
    config = {
      frameless = false;
      plugins = {
        youtubeAdblock.enable = true;
        fakeNitro.enable = true;
        noF1.enable = true;
        alwaysAnimate.enable = true;
        whoReacted.enable = true;
        callTimer.enable = true;
        petpet.enable = true;
        readAllNotificationsButton.enable = true;
        clearUrls.enable = true;
        # equicord plugins
        betterForwards.enable = true;
        noTypingAnimation.enable = true;
      };
    };
  };
}
