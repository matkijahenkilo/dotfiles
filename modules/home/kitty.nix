{ lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "kitty";
  };

  xdg.desktopEntries.kitty = {
    name = "Kitty";
    genericName = "Terminal emulator";
    exec = "kitty";
    icon = ../../assets/tsih.png;
    terminal = false;
  };
}
