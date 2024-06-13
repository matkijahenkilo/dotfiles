{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  xdg.systemDirs.config = [ "/etc/xdg" ]; # Workaround (https://github.com/danth/stylix/issues/412)
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/pop.yaml";
    image = ./../../assets/bg;
    polarity = "dark";

    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
    };

    fonts = {
      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
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
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
  };
}
