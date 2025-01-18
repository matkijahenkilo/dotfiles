{ pkgs, ... }: {
  imports = [
    # Essentials
    ../nix.nix
    ../git.nix
    ../zsh.nix
    ../syncthing.nix

    # CLI
    ../micro.nix
    ../yt-dlp.nix
    ../gallery-dl.nix
    ../fastfetch.nix

    # GUI
    # ../sessions/hyprland.nix
    ../stylix.nix
    ../kitty.nix
    ../fcitx5.nix
    ../vscode.nix
    ../firefox.nix
    ../obs-studio.nix
  ];

  home.packages = with pkgs; [
    vesktop
    vlc
    obsidian
    xivlauncher
    telegram-desktop
    qbittorrent
  ];
}