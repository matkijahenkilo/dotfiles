{ pkgs, ... }:
{
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
