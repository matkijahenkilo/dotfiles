{ pkgs, ... }:
{
  imports = [
    ../nixcord.nix
    ../firefox.nix
    ../kitty.nix
    ../stylix.nix
    ../thunderbird.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    vlc
    dav1d
    krita
    ferdium
    obsidian
    qbittorrent
    libreoffice
    telegram-desktop
  ];
}
