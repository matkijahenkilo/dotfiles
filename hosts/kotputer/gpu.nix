{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
