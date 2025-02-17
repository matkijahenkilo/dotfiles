{ pkgs, config, ... }:
let
  template =
    let
      inherit (config.lib.stylix) colors;
      inherit (config.stylix) fonts;
    in
    import ./template.nix { inherit colors fonts; };
in {
  home.packages = with pkgs; [
    (discord-canary.override {
      withOpenASAR = true;
    })
    (discord.override {
      withOpenASAR = true;
    })
  ];
  xdg.configFile = {
    "discordcanary/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true
      }
    '';
    "discord/settings.json".text = ''
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
  };
}