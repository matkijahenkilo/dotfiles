{ pkgs, ... }: {
  imports = [
    ../nix.nix
    ../git.nix
    ../neovim.nix
    ../kitty.nix
    ../fish.nix
    ../fastfetch.nix
    ../stylix.nix
    ../syncthing.nix
    ../fcitx5.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [
    vesktop
    bottles
  ];
}
