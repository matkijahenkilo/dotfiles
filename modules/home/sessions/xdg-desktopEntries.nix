{ ... }:
let
  assets = ../../../assets;
in {
  xdg.desktopEntries = {
    vesktop = {
      name = "Vesktop";
      exec = "vesktop";
      terminal = false;
      categories = [ "Application" "Network" ];
    };
    kitty = {
      name = "Kitty";
      genericName = "Terminal emulator";
      exec = "kitty";
      icon = assets + /cat.png;
      terminal = false;
    };
  };
}