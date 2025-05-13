{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
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
}
