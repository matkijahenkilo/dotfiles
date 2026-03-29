{ pkgs, ... }:
{
  imports = [
    ../discord.nix
    ../firefox.nix
    ../kitty.nix
    # ../stylix.nix # will break DE when using home-manager as NixOS module
    ../thunderbird.nix
    ../mpv.nix
  ];

  home.packages = with pkgs; [
    krita
    ferdium
    obsidian
    qbittorrent
    libreoffice
    (stoat-desktop.override {
      electron_38 = pkgs.electron;
    })
    telegram-desktop
    jetbrains.idea-oss
  ];
}
