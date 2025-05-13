{ pkgs, ... }:
{
  console = {
    keyMap = "br-abnt2";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-124n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };
  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };
}
