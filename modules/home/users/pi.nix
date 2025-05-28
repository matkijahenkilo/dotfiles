{ pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/cli.nix
    ../fastfetch.nix
  ];
}
