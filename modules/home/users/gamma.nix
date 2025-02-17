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
    ../sessions/plasma
    ../stylix.nix
    ../fcitx5.nix
    ../thunderbird.nix
    ../firefox.nix
    ../flameshot.nix
    ../vscode.nix
    ../discord
  ];

  home.packages = (
  let
    path = ../../../pkgs;
  in
  let
    krisp-patcher = pkgs.callPackage (path + /krisp-patcher) { };
    wxedid = pkgs.callPackage (path + /wxedid) { };
    dtkit-patch = pkgs.callPackage (path + /dtkit-patch) { };
  in [
    wxedid
    krisp-patcher
    dtkit-patch
  ]) ++ (with pkgs; [
    bottles
    krita
    vlc
    telegram-desktop
    qbittorrent
    wl-clipboard

    wine
    archipelago
    lutris
    suyu
    xivlauncher
  ]);
}