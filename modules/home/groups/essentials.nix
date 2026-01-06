{ pkgs, ... }:
{
  imports = [
    ../nix.nix
    ../git.nix
    ../zsh.nix
    ../direnv.nix
  ];

  home.packages = with pkgs; [ speedtest-cli ];
}
