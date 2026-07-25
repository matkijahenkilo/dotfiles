{ pkgs, ... }:
{
  imports = [
    ../discord.nix
    ../firefox.nix
    ../kitty.nix
    # ../stylix.nix # will break DE when using home-manager as NixOS module
    ../thunderbird.nix
    ../mpv.nix
    ../krita
  ];

  home.packages = with pkgs; [
    obsidian
    qbittorrent
    libreoffice
    telegram-desktop
    jetbrains.idea
  ];
}
