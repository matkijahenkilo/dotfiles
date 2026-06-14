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
      extraPackages = with pkgs; [
        libvdpau-va-gl
        libva-vdpau-driver
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };
  };

  # gfx1102 - Radeon RX 7600
  services.ollama = {
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.0.2";
  };

  # fix monitor not using full rgb in tty screens
  hardware.display = {
    outputs."HDMI-A-1".edid = "edid-custom.bin";
    edid = {
      packages = [
        (pkgs.runCommand "edid-custom" { } ''
          mkdir -p "$out/lib/firmware/edid"
          cp ${./edid-custom.bin} $out/lib/firmware/edid/edid-custom.bin
        '')
      ];
    };
  };
}
