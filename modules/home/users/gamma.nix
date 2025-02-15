{ pkgs, libs, ... }: {
  imports = [
    # Essentials
    ../nix.nix
    ../git.nix
    ../zsh.nix
    ../syncthing.nix
    ../gschemas.nix

    # CLI
    ../yt-dlp.nix
    ../gallery-dl.nix
    ../kitty.nix
    ../micro.nix
    ../fastfetch.nix

    # GUI
    ../stylix.nix
    ../fcitx5.nix
    ../flameshot.nix
    ../vscode.nix
    ../discord.nix
  ];

  home.packages = (
  let
    path = ../../../pkgs;
  in
  let
    krisp-patcher = pkgs.callPackage (path + /krisp-patcher) { };
    wxedid = pkgs.callPackage (path + /wxedid) { };
  in [
    wxedid
    krisp-patcher
  ]) ++ (with pkgs; [
    vesktop
    bottles
    krita
    vlc

    wine
    archipelago
    lutris
    suyu
    xivlauncher

    qbittorrent
    wl-clipboard
  ]);
}