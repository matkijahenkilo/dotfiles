{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.marisa.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
  };
}
