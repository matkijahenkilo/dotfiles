{ lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "kitty";
  };

  xdg.desktopEntries.Kitty = {
    name = "Kitty";
    genericName = "Terminal emulator";
    exec = "kitty";
    icon = ../../assets/cat.png;
    terminal = false;
  };
}
