{ pkgs, ... }: {
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
    ../vscode.nix
    ../discord.nix
  ];

  home.packages = (
   let
     krisp-patcher = pkgs.callPackage ../krisp-patcher { };
     wxedid = pkgs.callPackage ../wxedid { };
   in [
    krisp-patcher
    wxedid
  ]) ++ (with pkgs; [
    vesktop
    bottles
    archipelago
    krita
    wine
    lutris
    qbittorrent
    wl-clipboard
  ]);
}