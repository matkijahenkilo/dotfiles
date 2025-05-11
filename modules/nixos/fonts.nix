{ pkgs, ... }: {
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
      noto-fonts-emoji
      noto-fonts-extra
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