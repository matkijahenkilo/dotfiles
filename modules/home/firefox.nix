{ lib, ... }:
let
  preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };
in
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ ];
    profiles = {
      tsih = {
        id = 0;
        search.default = "google";
        isDefault = true;
        settings = preferences;
      };
      nanako = {
        id = 1;
        search.default = "google";
        settings = preferences;
      };
    };
    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      HardwareAcceleration = true;
      NetworkPrediction = false;
      OfferToSaveLogins = true;
    };
  };

  home.sessionVariables = {
    BROWSER = lib.mkDefault "firefox";
  };
}
