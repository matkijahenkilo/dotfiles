{ lib, pkgs, ... }:
{
  services.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;
  hardware.alsa.enablePersistence = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
