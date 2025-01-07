{ pkgs, ... }: {
  imports = [
    ../nix.nix
    ../git.nix
    ../micro.nix
    ../kitty.nix
    ../fish.nix
    ../zsh.nix
    ../fastfetch.nix
    ../stylix.nix
    ../syncthing.nix
    ../fcitx5.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    vesktop
    bottles
    archipelago
    krita
  ];
}