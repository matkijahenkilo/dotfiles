{ pkgs, ... }:
{
  imports = [
    ../discord
    ../firefox.nix
    ../kitty.nix
    ../stylix.nix
    ../thunderbird.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    vlc
    krita
    obsidian
    qbittorrent
    libreoffice
    telegram-desktop
  ];
}
