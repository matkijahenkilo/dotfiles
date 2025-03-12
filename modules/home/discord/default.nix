{ pkgs, config, ... }:
let
  template =
    let
      inherit (config.lib.stylix) colors;
      inherit (config.stylix) fonts;
    in
    import ./template.nix { inherit colors fonts; };
in {
  home.packages = (
    let
      path = ../../../pkgs;
    in
    let
      krisp-patcher = pkgs.callPackage (path + /krisp-patcher) { };
    in [
      krisp-patcher
  ]) ++ (with pkgs; [
    (discord-canary.override {
      withOpenASAR = true;
    })
    (discord.override {
      withOpenASAR = true;
    })
  ]);
  xdg.configFile =
    let
      customSettings = ''
        {
          "SKIP_HOST_UPDATE": true,
          "BACKGROUND_COLOR": "#2b2d31",
          "openasar": {
            "setup": true,
            "quickstart": true,
            "css": "${template}"
          },
          "chromiumSwitches": {}
        }
      '';
    in {
      "discordcanary/settings.json".text = customSettings;
      "discord/settings.json".text = customSettings;
    };
}