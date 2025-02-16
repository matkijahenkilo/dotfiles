{ pkgs, ... }:
let
  assets = ../../../assets;
in {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-kde
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "kde"
        ];
      };
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
      };
    };
  };

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