{ inputs, pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      size = 32;
      package = pkgs.banana-cursor;
      name = "Banana";
    };

    fonts = {
      sizes = {
        desktop = 10;
        applications = 10;
        terminal = 14;
        popups = 10;
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        mangohud.enable = false;
        vscode.profileNames = [ "marisa" ];
        firefox.profileNames = [
          "tsih"
          "nanako"
        ];
        fcitx5.enable = false; # disabled until options to customize it specifically are made
      };
    }
  ];
}
