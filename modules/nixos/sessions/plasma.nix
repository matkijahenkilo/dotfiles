{ pkgs, ... }:
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

  programs.partition-manager.enable = true;
}
