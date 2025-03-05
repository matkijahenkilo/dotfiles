{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      amdvlk = {
        enable = true;
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    glxinfo
  ];
}