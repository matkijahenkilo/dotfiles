{ pkgs, ... }:
{
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-124n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code

      source-han-sans
      dejavu_fonts
      font-awesome
      roboto
      roboto-serif
      roboto-mono
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      # jp fonts
      source-han-sans
      source-han-mono
      source-han-serif
    ];
  };
}
