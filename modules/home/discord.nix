{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  # https://github.com/FlameFlag/nixcord
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord = {
      equicord.enable = true;
      vencord.enable = false;
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
        # equicord plugins
        forwardAnywhere.enable = true;
        noTypingAnimation.enable = true;
      };
    };
  };

  home.packages =
    let
      krisp-patcher = pkgs.callPackage (../../pkgs/krisp-patcher) { };
    in
    [
      (pkgs.writeShellScriptBin "discord-patch-krisp" "find ~/.config/discord -name 'discord_krisp.node' -exec ${lib.getExe krisp-patcher} {} \\;")
    ];
}
