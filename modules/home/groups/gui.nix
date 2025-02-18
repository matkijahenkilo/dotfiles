{ pkgs, ... }: {
  imports = [
    ../discord
    ../firefox.nix
    ../kitty.nix
    ../obs-studio.nix
    ../stylix.nix
    ../thunderbird.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    vlc
    krita
    obsidian
    qbittorrent
    telegram-desktop
  ];
}