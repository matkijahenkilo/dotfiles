{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code

      source-han-sans
      symbola
      dejavu_fonts
      font-awesome
      open-dyslexic
      roboto
      roboto-serif
      roboto-mono
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}