{ pkgs, ... }:
{
  services = {
    displayManager.plasma-login-manager.enable = true;
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
