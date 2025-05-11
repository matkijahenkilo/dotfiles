{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  xdg.systemDirs.config = [ "/etc/xdg" ]; # Workaround (https://github.com/danth/stylix/issues/412)
  stylix = {
    enable = true;
    # image = ../../assets/bg;
    polarity = "dark";
    base16Scheme = {
      base00 = "201010";
      base01 = "302020";
      base02 = "403030";
      base03 = "908080";
      base04 = "b0a0a0";
      base05 = "c0b0b0";
      base06 = "e0d0d0";
      base07 = "ffdfdf";
      base08 = "eb008a";
      base09 = "f29333";
      base0A = "f8ca12";
      base0B = "37b349";
      base0C = "d40047";
      base0D = "b41b1b"; # accent color
      base0E = "b31e8d";
      base0F = "7a2d00";
    };

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

    targets = {
      mangohud.enable = false;
      vscode.profileNames = [ "marisa" ];
      firefox.profileNames = [
        "tsih"
        "nanako"
      ];
    };
  };
}