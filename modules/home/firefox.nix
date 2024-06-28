{ lib, ... }: {
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [  ];
    profiles = {
      tsih = {
        id = 0;
        search.default = "Google";
        isDefault = true;
      };
      nanako = {
        id = 1;
        search.default = "Google";
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