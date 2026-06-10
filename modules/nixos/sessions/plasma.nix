{ lib, pkgs, ... }:
{
  services = {
    # sddm and plasma-login-manager degrades everything when starting up plasma from them
    # simply starting plasma with `startplasma-wayland` from a tty is sufficient
    # for now, Ly is my go to display manager because it doesn't degrade the session.
    displayManager.ly.enable = true;
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];

  environment.systemPackages = with pkgs.kdePackages; [
    korganizer
    # required stuff for syncing CalDAV with kde's calendar
    # requires a password manager like kwallet too, it seems
    akonadi-calendar
    kdepim-addons
    kdepim-runtime
  ];

  programs.partition-manager.enable = true;

  # force gtk apps to use kde file picker
  environment.sessionVariables.GTK_USE_PORTAL = "1";
}
