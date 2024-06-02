{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  stylix = {
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/summercamp.yaml";
    image = ./../assets/bg;
    polarity = "dark";

    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
    };

    fonts = {
      sizes = {
        applications = 10;
        terminal = 11;
        desktop = 9;
        popups = 9;
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      monospace = {
        package = pkgs.nerdfonts;
        name = "Fira Code nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.85;
      desktop = 1.0;
      popups = 1.0;
    };
  };
}
