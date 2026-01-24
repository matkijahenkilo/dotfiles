{ pkgs, ... }:
{
  imports = [
    ../discord.nix
    ../firefox.nix
    ../alacritty.nix
    # ../stylix.nix # will break DE when using home-manager as NixOS module
    ../thunderbird.nix
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
