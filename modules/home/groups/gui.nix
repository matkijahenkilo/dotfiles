{ pkgs, ... }:
{
  imports = [
    ../nixcord.nix
    ../firefox.nix
    ../kitty.nix
    # ../stylix.nix # will break DE when using home-manager as NixOS module
    ../thunderbird.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    mpv
    vlc
    krita
    ferdium
    obsidian
    qbittorrent
    libreoffice
    telegram-desktop
  ];
}
