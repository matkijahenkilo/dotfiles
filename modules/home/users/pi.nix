{ inputs, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix
  ];
}
