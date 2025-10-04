{ lib, ... }:
let
  assets = ../../assets;
in
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
    icon = assets + /cat.png;
    terminal = false;
  };
}
