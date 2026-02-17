{ ... }:
{
  services.journald.extraConfig = ''
    MaxFileSec=7day
  '';
}