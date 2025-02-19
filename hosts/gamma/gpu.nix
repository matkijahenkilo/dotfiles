{ pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk

        libvdpau-va-gl
        libva-vdpau-driver
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        amdvlk

        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    glxinfo
  ];
}