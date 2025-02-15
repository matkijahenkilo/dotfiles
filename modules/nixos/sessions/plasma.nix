{ pkgs, ... }: {
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    bluedevil
  ];
}