{ lib, pkgs, ... }:
{
  systemd.user.services.xmousepasteblock = {
    Unit.Description = "Userspace tool to disable middle mouse button paste in Xorg";
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.xmousepasteblock}";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # https://github.com/milaq/XMousePasteBlock#kde-plasma-525-and-above
  home.activation.klipperNoEmptyClipboard = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 \
      --file klipperrc --group General --key NoEmptyClipboard --type bool false
  '';
}
