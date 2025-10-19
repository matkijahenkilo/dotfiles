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
    mpv
    krita
    ferdium
    obsidian
    qbittorrent
    libreoffice
    telegram-desktop
  ];
}
