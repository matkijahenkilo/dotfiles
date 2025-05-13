{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  xdg.systemDirs.config = [ "/etc/xdg" ]; # Workaround (https://github.com/danth/stylix/issues/412)
  stylix = {
    enable = true;
    # image = ../../assets/bg;
    polarity = "dark";
    base16Scheme = {
      base00 = "190c0b"; # ----
      base01 = "331816"; # ---
      base02 = "4c2421"; # --
      base03 = "66302c"; # -
      base04 = "ffc9c5"; # +
      base05 = "ffd6d4"; # ++
      base06 = "ffe4e2"; # +++
      base07 = "fff1f0"; # ++++
      base08 = "ff7870"; # red, accent color
      base09 = "ffc070"; # orange
      base0A = "f7ff70"; # yellow
      base0B = "70ff78"; # green
      base0C = "70f7ff"; # cyan
      base0D = "7870ff"; # blue
      base0E = "ff70b0"; # purple
      base0F = "7f3430"; # brown
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
      fcitx5.enable = false; # disabled until options to customize it specifically are made
    };
  };
}
