{ lib, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        title = "(´｡• ω •｡`)";
        dimensions = {
          columns = 130;
          lines = 35;
        };
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "alacritty";
  };

  xdg.desktopEntries.alacritty = {
    name = "Alacritty";
    genericName = "Terminal emulator";
    exec = "alacritty";
    icon = ../../assets + /cat.png;
    terminal = false;
  };
}
