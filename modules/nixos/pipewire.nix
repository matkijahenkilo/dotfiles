{ lib, ... }: {
  services.pulseaudio.enable = lib.mkForce false;
  # dl alsa-utils and use alsamixer
  # to disable automute (￣ ￣|||)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
