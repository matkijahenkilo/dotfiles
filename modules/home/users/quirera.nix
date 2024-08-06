{ pkgs, ... }: {
  imports = [
    # Essentials
    ../nix.nix
    ../git.nix
    ../fish.nix
    ../syncthing.nix

    # CLI
    ../neovim.nix
    ../yt-dlp.nix
    ../gallery-dl.nix
    ../fastfetch.nix

    # GUI
    ../sessions/hyprland.nix
    ../stylix.nix
    ../kitty.nix
    ../fcitx5.nix
    ../vscode.nix
    ../firefox.nix
  ];

  home.packages = with pkgs; [
    vesktop
    vlc
    obsidian
    xivlauncher
  ];
}
