{ pkgs, ... }: {
  imports = [
    ../nix.nix
    ../git.nix
    ../neovim.nix
    ../kitty.nix
    ../fish.nix
    ../fastfetch.nix

    ../session-hyprland.nix
    ../stylix.nix
    ../syncthing.nix
    ../fcitx5.nix
    ../vscode.nix
    ../firefox.nix
    ../yt-dlp.nix
    ../gallery-dl.nix
  ];

  home.packages = with pkgs; [
    vesktop
  ];
}
