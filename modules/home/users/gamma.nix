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
    ../discord.nix
  ];

  home.packages = (
   let
     krisp-patcher = pkgs.callPackage ../krisp-patcher { };
   in [
    krisp-patcher
  ]) ++ (with pkgs; [
    vesktop
    bottles
    archipelago
    krita
  ]);
}